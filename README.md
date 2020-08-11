# Creating CSE-VM-3.0

This repository provides resources for recreating the CSE-VM virtual machine supporting some courses at the University of Texas at Arlington.

This release is currently Alpha 2, and [is available for download](https://drive.google.com/file/d/1fkxUIS4-4vRFIjj4T3hh4kfzhwF844mH/view?usp=sharing) (3.8 GB, MD5 is b1af6a01ee3630f44603ef0c65943eca).

## Identification

As of version 3.0, this virtual machine name is CSE-VM, and the release name is CSE-VM-3.0. 

An instructor may customize this release by importing the .ova file into VirtualBox, making changes, and exporting a new .ova file, which should be named with the cource and section (and optional version) appended, e.g., CSE-VM-3.0-CSE1325-001.ova.

Major version numbers correspond to the underlying Ubuntu Long Term Support (LTS) release: 1.x was built on Lubuntu 16.04, 2.x was built on Lubuntu 18.04, and 3.x is built on Xubuntu 20.04.

> The switch to Xubuntu reflects the rewrite of the LDXE desktop on which Lubuntu is built, from Gtk+ to Qt, leading to concern over possible stability issues. Xfce, on which Xubuntu is based, is Gtk+ based (currently used for CSE1325), lightweight, and stable.

Minor version numbers indicate the semester for which that virtual machine is intended. 3.0 indicates fall of 2020, 3.1 spring of 2021, 3.2 fall of 2021, and 3.3 spring of 2022. Fall of 2022 will then move to the next LTS release, 22.04, as version 4.0, with whatever desktop seems most advantageous at that time.

## Configure Host System

This release of CSE-VM is built on an x64 Ubuntu 20.04 host system, although a Windows 10 or Mac OS X host should work as well. This release has been tested under Ubuntu 20.04 and Windows 10.

1. Install the latest version of Oracle VirtualBox from [the VirtualBox website](https://www.virtualbox.org/). 

## Create a Xubuntu 20.04 Virtual Machine

NOTE: Oracle changes the VirtualBox interface regularly. These instructions are based on VirtualBox 6.1.6_Ubuntu r137129.

[Download Xubuntu 20.04](https://xubuntu.org/download/). The filename should be xubuntu-20.04-desktop-amd64.iso, and is close to 2 GB in size.

1. Launch VirtualBox.
2. Select Machine -> New...
3. In the Create Virtual Machine dialog, select a name (see [Identification](#identification)) and set Type to Linux, Version to Ubuntu (64-bit), Memory Size to 2048 MB, and Hard Disk to Create a Virtual Hard Disk Now. Click Create.
4. In the Create Virtual Hard Disk dialog, set File Size to 10 GB, File Type to VDI, and Storage to Dynamically Allocated. Click Create. You should see your new VM in the list in the VirtualBox Manager main window, marked as Powered Off.
5. Select your new VM and click Settings. Accept all defaults except for the following changes.
    * Under General -> Advanced, enable Shared Clipboard.
    * Under Display -> Screen, set Video Memory to 128 MB and Video Controller to VBoxSVGA. Ignore the warning about the video configuration; this is the correct configuration.
    * Under Storage -> Storage Devices -> Controller:IDE, select Empty. Click the CD icon under Attributes and select Choose a Disk File. Select xubuntu-20.04-desktop-amd64.iso from the host file system.
6. Accept the Settings changes, then click Start to launch the new virtual machine. In the Select Start-up Disk dialog, select xubuntu-20.04-desktop-amd64.iso. Click Start. You should see the Xubuntu logo and some scrolling status messages as the operating system boots into the virtual machine. Patience.
7. Xubuntu will be running directly from the .iso file for now. 
    * At the welcome screen that should open automatically, select English and then click Install Xubuntu. 
    * Click Continue to accept the default keyboard layout.
    * Enable both Download Updates and Install Third-Party Software and click Continue.
    * Select Erase Disk and Install Xubuntu (this is your virtual disk, NOT your host's disk!) and click Install Now and then Continue. Installation will begin in a background process.
    * Select Arlington, Texas as the current location and click Continue.
    * Set Your Name to Student, Computer's Name to Maverick, username and password both to student, enable Log In Automatically, and click Continue. Installation will continue in the foreground. This may take some time. Patience.
8. Once installation completes, click Restart Now. Press Enter when prompted to remove the media (this is automatic in a virtual machine). 

Once rebooted, the virtual machine is ready for configuration. If the virtual machine asks for media in the future, select Host Drive. To prevent this, with the virtual machine off, select the virtual machine in the VirtualBox main window, click Settings -> Storage, click the CD icon, and select Remove Disk from Virtual Drive.

## How to Install Packages

Xubuntu, like most Linux distributions, is package-centric. A package contains one or more programs from a central repository of tens of thousands of packages, and will be automatically updated by the system for each student running the virtual machine.

**To install a package into Xubuntu, e.g., figlet, simply type ``sudo apt install figlet`` at the bash command line** in a terminal (Control-Alt-t). You may be asked for the system password ("student"), to press Enter to confirm the packages to be installed, and in the case of proprietary packages to accept a license agreement (Tab and Enter). 

Multiple packages may be included on the same command line, e.g., ``sudo apt install figlet boxes lolcat`` will install 3 packages, but will halt if an installation fails.

To launch a program after its package has been installed, type its package name unless otherwise indicated, or open the start menu and start typing its name, or navigate the category menus under start. The bash command ``man figlet`` provides the manual for the figlet program.

## Configure Guest Utilities

The guest utilities package improves integration of the virtual Linux desktop with the host desktop (such as Windows, Mac OS, or Linux).

In Xubuntu, press Control-Alt-t to open a terminal.

1. [Install the following package](#how-to-install-packages) to better integrate Xubuntu with the host system: **virtualbox-guest-utils**
2. Add your user to the VBox user group (required should you decide to share a folder with the host OS) using **``sudo usermod -a -G vboxsf student``**

Note: We no longer recommend sharing folders between host and virtual operating systems. Text editors sometimes complain that files cannot be saved to the shared folder, necessitating that the file be save to the virtual file system and then copied to the shared folder. Also, VirtualBox inexplicably sets all text files it creates on the shared folder as *executable*, which looks weird.

Instead, you can clone your GitHub account to both the virtual and host operating system filesystems. Then, push and pull as needed to transfer your entire project. As a bonus, you'll have regularly updated backups. Woot!

## Autosize the Desktop

In the VirtualBox menu, select Devices -> Shared Clipboard -> Bidirectional. This will enable copy / paste from this document to the terminal or into dialogs.

In Xubuntu, press Control-Alt-t to open a terminal.

1. [Install the following package](#how-to-install-packages) to better integrate Xubuntu with the host system: **virtualbox-ext-pack**
2. Type the following command to reboot the virtual machine: **``sudo reboot``**
3. In the VirtualBox menu, select View -> Autosize Display. This will resize the Xubuntu desktop to match the size of the window in which it is running.
4. Reboot again, either with ``sudo reboot`` at the command line, or by clicking the start menu (upper left, with a mouse on it) -> power button -> Restart.

## Configure the Panel

Xubuntu supports multiple panels (one of which Windows sometimes calls the "task bar"). Configure it to operate more like Windows:

1. Right-click the start menu (in the upper left corner, with a mouse on it) and select Panel -> Panel Preferences. Deselect "Lock Panel", then click Close.
2. Drag the panel to the bottom, using the newly visible "friction pad" on the far left. 
3. Right-click the start menu (now in the lower right corner, where students will expect it) and select Panel -> Panel Preferences. Select "Lock Panel". Don't click Close yet!
4. In the Appearance tab, Icons section, enable Adjust Size Automatically. Under Opacity, set both Enter and Leave to 100%.
5. In the Items tab, configure the following items. To add an item, click the green +, select it from the list, and click +Add. After adding an item, select it and click the gear icon on the right to configure it. To configure a Launcher, click the green + to select an installed application from the list as specified.
    * **Whisker Menu:** The defaults should be fine. Changing Panel Button -> Display to Icon and Title, and setting the Title to Start, may be more intuitive for Windows users.
    * **Launcher - Firefox**
    * **Launcher - Terminal Emulator**
    * **Launcher - File Manager:** This is Thunar
    * **Launcher - Text Editor:** This is Gedit
    * **Screenshot**: This is gnome-screenshot, not scrot
    * **Separator** x2: This is near the top of the Add New Items list, just below Launcher. Add 2.
    * **Window Buttons**
    * **Separator**
    * **Notification Area**
    * **Indicator Plugin**
    * **Status Notifier Plugin**
    * **PulseAudio Plugin**
    * **Separator**
    * **System Load Monitor:** Set Monitor to xfce-taskmanager. Set Update Interval to 0.5 seconds, Power-Saving Interval is 1 second. Enable all 4 monitors, with Options set to cpu, mem, and swap (uptime supports no Options). 
    * **Separator**
    * **Clock**
    * **Separator**
    * **Action Buttons:** Shutdown with "Show Confirmation Dialog"
6. Click Close now!

## Set the Wallpaper

Set a distinctive wallpaper to clearly indicate the window running the virtual machine.

1. Download a suitable image [such as uta_college_park.jpg](https://images.app.goo.gl/iPCxJNgdsNHKVwNr7) into the Pictures folder.
2. Right-click the desktop and select Desktop Settings.
3. Set Folders to Pictures.
4. Select the image, e.g., uta_college_park.jpg.
5. Set Style to Zoomed.
6. Click Closed.

## Open the menu on Super

Configure Xubuntu to open the start menu with the Super key (called the Windows key for Windows 10), since this is familiar behavior to Windows users.

1. Select the start menu -> Settings -> Keyboard -> Application Shortcuts.
2. Click Add.
3. Type ``xfce4-popup-whiskermenu`` as the command, deselect "Use Startup Notification", and click OK.
4. When prompted, press Super (the key with the Windows logo on it).

If you look through the list, you'll see ``xfce4-popup-whiskermenu`` in the alphabetized Command column, with ``Super L`` associated with it in the Shortcut column.

## Usability Package Installations

Install the following packages.

1. Install the following packages to support the 'div' script: ``figlet boxes lolcat``
3. Install the following package to support locating files anywhere by name fragment: ``mlocate``
3. Install the following package to support searching PDFs, e.g., lecture notes: ``pdfgrep``
4. Install the following package for quick screenshots: ``scrot``

## Manual Program Installations

A few executables are not available in the system repository, but can be added to the /home/student/bin directory. NOTE: Ubuntu will automatically detect this directory and add it to the student's path each time bash is launched.

3. Create directory ~/bin using this bash command: ``mkdir ~/bin``  
4. Add the [following executable](https://the.exa.website/install) to bin to support the lt and lx directory listers: ``exa``
5. Add the [following JAR file](https://plantuml.com/download) to bin to support UML diagram generation: ``plantuml.jar``
6. Add the following script to bin to run Plant UML as an executable (use ``chmod a+x plantuml`` to make it executable): ``plantuml``

         #!/usr/bin/env bash
         /usr/bin/java -jar /home/student/bin/plantuml.jar $@

## Popular Editor Installations

Xubuntu defaults to Mousepad, a perfectly reasonable Notepad equivalent. Some students want... more.

1. Install the two gedit packages as a more capable replacement for mousepad as default editor: ``gedit gedit-plugins``
2. Install Code::Blocks as an optional editor: ``codeblocks``
2. Use this command to install Visual Studio Code as an optional editor, which can then be launched as ``code``: ``sudo snap install --classic code``

## Development Package Installations

4. Install the following package to provide developer documentation: ``devhelp``
1. Install the following package to support C/C++ development: ``build-essential``
2. Install the following packages to support C++ GUI development (the -doc versions add documentation to devhelp): ``libgtkmm-3.0-dev libgstreamermm-1.0-dev libgtkmm-3.0-doc libgstreamermm-1.0-doc``
3. Install the following packages to support Java development (note: openjdk-14-jdk is now available, if preferred): ``openjdk-11-jdk``
4. Python 3 is preinstalled, but install the following package to manage Python plug-ins: ``python3-pip``
3. Install the following package to support debugging and profiling Linux programs: ``valgrind``
2. Install the following package to support version control (or install ``git-all``, if a stand-alone GUI is also desired): ``git``
3. Install the following package to support visual differencing and merging: ``meld``
5. Install the following package to support counting lines of code: ``cloc``

## Update .bashrc

Edit ~/.bashrc so that the bash prompt ends in a neutrally-colored $ when the previous command concluded successfully, but in a red @ when the previous command failed. (This helps to teach students why returning an int from main is important.)  Replace this line:

``PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '``

with

``PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$( [ $? == 0 ] && echo "\$ " || echo "\[\033[1;31m\]@ \[\033[00m\]" '``

## Add .bash_aliases

Add a .bash_aliases to the home directory, i.e., ~/.bash_aliases.  The content of this file is provided in Appendix A, and also in this repository as bash_aliases (note the missing leading dot, which you must add after copying). It may be tweaked by a competent bash developer, or by students after importing the appliance. 

(NOTE: When bash launches, the .bashrc script is run, and it will automatically execute .bash_aliases if it exists.)

## Add .gitconfig

Add a .gitconfig to the home directory, i.e., ~/.gitconfig.  The content of this file is provided in Appendix B, and also in this repository as gitconfig (note the missing leading dot, which you must add after copying). It may be tweaked by a competent git guru, or by students after importing the appliance. 

(NOTE: When git first launches, it will ask for the student's name and email and add them to .gitconfig.)


## Export

Exporting the new virtual machine to a .ova file simplifies distribution to students.

Be sure the virtual machine is configured the way you want it to boot first for the students. Disconnect any shared drives. Changed to windowed rather than full screen mode. Ensure the user to auto-login in student, and that the password is student (they can change it after importing the appliance).

1. In the VirtualBox main window select File -> Export Appliance. 
2. Select the OVF 1.0 format and click Next. 
3. Complete the product information. Note that if any license is specified, then the students will be asked to accept that license. 
4. Click Export. This may take some time. Patience.

## Appendix A

Copy the text below into the student home directory of the virtual machine as file .bash_aliases. This file, along with the configuration documented above, adds the following bash commands to assist the students.

* **e hello.cpp** – Opens the file(s) in each associated default editor (works with .pdf, .png, .jpg... all associated types!)
* **eall** – Opens .h, .cpp, .java, .py, and Makefile in gedit.  Tabs are sorted by class name, 
with each .h just to left of its .cpp, and with Makefile to the far right.
* **ec class** – Opens class.h and class.cpp
* **c17 hello.cpp** – Compiles the file(s) using C++ 17 syntax
* **g17 dialog.cpp** – Compiles the file(s) using C++ 17 syntax with the gtkmm 3.0 libraries
* **div** – Displays a colorful start-of-build marker to help you find your first error message
* **notify message** – Displays AND speaks the message, preceded by  "success:" if the previous command succeeded, "failed:" if not
* **m** – Identical to make, but starts with "div" and ends with "notify"
* **git lg** – Displays colorful list of all commits, with ASCII-graphical map of branches
* **git dates** – Same as lg, but commit date and time are to the second (note that clever students can manipulate these date and time records, even on GitHub)
* **cloc main.cpp Makefile** – Counts the Lines Of Code in the filenames
* **pdfgrep polymorphism Syllabus.pdf** – prints all lines in Syllabus.pdf containing the word "polymorphism"
* **pdfgreps polymorphism** – prints all lines from all PDF files recursively that contain "polymorphism" (useful for searching all lectures or class notes)
* **doc** – Change to the Documents folder
* **dl** – Change to the Downloads folder
* **dev** – Change to your development folder (git repository, if used in this class), students may configure at top of .bash_aliases
* **prof** – Change to the professor's git repository for the class (if used in this class), students may configure at top of .bash_aliases
* **paths** – Shows the path, one directory per line, which is easier to read
* **mkcd newdir** – Creates new directory newdir, and changes to it
* **exa** – A more powerful ls (try lx and lt)
* **backup** – Duplicates the current directory to a date-tagged peer directory (be careful with large directory structures!)
* **meld** – Compares and merges files visually, particularly helpful with git merges
* **valgrind** – Supports debugging and profiling Linux applications

---

```
# #####################################################
# File system bookmarks (add other aliases as required)

alias doc='cd ~/Documents/'
alias dl='cd ~/Downloads/'
alias dev='cd ~/cse1325/'           # Set to your development repository
alias prof='cd ~/dev/cse1325-prof'  # Set to your professor's repository

# #############
# Edit commands

# The EDITOR environment sets the default text editor for most text files
# Change this to your favorite editor, e.g., mousepad, nano, vi, etc
export EDITOR=gedit

# Open file(s) using the associated application, creating the file if it doesn't exist
e() {
 for file in "$@" ; do
    if [ ! -f "$file" ]; then
      touch "$file"
    fi
    xdg-open "$file"
  done
}

# Open the header and body of a C++ class
ec () {
  e $1.h $1.cpp
}

# Open all C++  (header then body), Java, and Python class files in alphabetical order, followed by Makefile
alias eall='shopt -s nullglob ; setsid gedit $(ls -1 *.h *.cpp *.java *.py | sort -t. -k1,1 -k2,2r) Makefile* makefile* ; shopt -u nullglob'

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
  make -j12 "$@"
  notify build complete
}

# roughly calculate changes from a previous iteration
cloc-delta() {
  for f in *.h *.cpp Makefile ; do diff $f $1; done | grep '<' | wc
}

# ########################
# Fix retext configuration
QT_STYLE_OVERRIDE="fusion"

```

## Appendix B

Copy the text below into the student home directory of the virtual machine as file .gitconfig, or download gitconfig from the repository and rename it. This file preconfigures git to operate conveniently, with colorful output, caching the GitHub credentials, setting difftool and mergetool to use meld, and adding a couple of aliases.

NOTE: Permanently caching the student's GitHub credentials is very convenient but assumes the student's laptop is protected, as these credentials are stored as a plain text file in the VM. To save the credentials only in memory and for a limited time (in this case, 8 hours), replace the credentials section with:

```
[credential]
    helper = cache --timeout 28800
```

---

```
[color]
	ui = auto
[alias]
	logline = log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit

	lg = !"git branches"
[push]
	default = simple
[credential]
	helper = store
[diff]
	tool = meld
[difftool]
	prompt = false
[difftool "meld"]
	cmd = meld "$LOCAL" "$REMOTE"
[merge]
	tool = meld
[mergetool "meld"]
	# Choose one of these 2 lines (not both!)
	cmd = meld "$LOCAL" "$MERGED" "$REMOTE" --output "$MERGED"
	# cmd = meld "$LOCAL" "$BASE" "$REMOTE" --output "$MERGED"
```

## Appendix C

Here are some additional hints for using VirtualBox.

* Go / exit full-screen by pressing RIGHT Control-f
* Change your password in bash via **``passwd``**
* Use View → AutoResize Display 
* Manage your VMs like data
    * Load as many VMs as you like, sharing a vdisk if desired – they don’t burn RAM unless they are running!
    * Take snapshots occasionally, for more info see [the VirtualBox documentation](http://news.filehippo.com/2014/06/use-snapshot-virtualbox/)
* NEVER close VirtualBox while a machine is running!
    * This is like ripping the battery out of your laptop!
    * Instead, shut down via ⏻ in the lower right corner, the Start menu, or bash’s **``sudo shutdown now``**




