# #####################################################
# File system bookmarks (add other aliases as required)

alias doc='cd ~/Documents/'
alias dl='cd ~/Downloads/'
alias usb='cd /media/ ; ls'
alias dev='cd ~/cse1325/'           # Set to your development repository
alias prof='cd ~/cse1325-prof/'     # Set to your professor's repository

# #############
# Edit commands

# The EDITOR environment sets the default text editor for most text files
# Change this to your favorite editor, e.g., mousepad, nano, vi, etc
export EDITOR=gedit

# Edit: open file(s) using the associated application, creating the file if it doesn't exist
e() {
 for file in "$@" ; do
    if [ ! -f "$file" ]; then
      echo " " >> "$file"
    fi
    # work-around for interation bug between xdg-open and gedit
    fn=$(basename -- "$file")
    ext="${fn##*.}"
    if [[ "$ext" =~ ^(h|cpp|java|py|txt)$ ]]; then 
        gedit "$file" &> /dev/null &
    else
        xdg-open "$file"
    fi
  done
}

# Edit Class: open the header and body of a C++ class
ec () {
  e $1.h $1.cpp
}

# Edit All: open all C++  (header then body), Java, and Python class files in alphabetical order, followed by Makefile
alias eall='shopt -s nullglob ; setsid gedit $(ls -1 *.h *.hpp *.c *.cpp *.java *.py | sort -t. -k1,1 -k2,2r) Makefile* makefile* ; shopt -u nullglob'

# #########
# EXA setup
alias lx='exa -lh --git --time-style iso'
alias lt='exa -lhT --level 3 --git --time-style iso'
export EXA_COLORS="da=1;34"

# ######################
# Miscellaneous commands

# Type 'backup' to duplicate current directory to time-stamped peer directory with optional tag (eg, -P01)
backup () {
  DIR=../$(basename $PWD)-$(date +%Y%m%d-%H%M%S)${1}
  mkdir -p $DIR
  cp -ru . $DIR
}

# enable mkcd to create and change to a new path
mkcd () {
  case "$1" in /*) :;; *) set -- "./$1";; esac
  mkdir -p "$1" && cd "$1"
}

# easier-to-read path command
paths() {
  echo $PATH | sed 's/:/\n/g'
}

# search hierarchy of PDF files
pdfgreps() {
  find . -iname '*.pdf' -exec pdfgrep $1 {} +
}

# ######################
# C++ build enhancements
#

# Quickie C++ 17 compiles
alias c17='g++ --std=c++17'
g17() {
  c17 "$@" `/usr/bin/pkg-config gtkmm-3.0 --cflags --libs`
}

# build divider (with a customizable message)
div() {
  default_msg="Starting a Build"
  msg="s='${1:-$default_msg}';print(s.center(31))"
  (python3 -c "$msg" ; echo $(date)) | boxes -p h4v2 -d ian_jones | lolcat
}

# notification e.g., that build is complete
notify() {
  result=$?
  notify-send -i $([ "$result" = 0 ] && echo info || echo error) "$@"
  (echo $([ "$result" = 0 ] && echo "success:" || echo "failed: ") "$@" | espeak &) > /dev/null 2>&1
  return $result
}

# enhanced make command
m() {
  div
  make -j "$@"
  notify build complete
}

# roughly calculate changes from a previous iteration
cloc-delta() {
  for f in *.h *.cpp Makefile ; do diff $f $1; done | grep '<' | wc
}

# ########################
# Fix retext configuration
QT_STYLE_OVERRIDE="fusion"



