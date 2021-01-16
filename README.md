# Creating CSE-VM-3.1

This repository provides resources for recreating the CSE-VM virtual machine appliance supporting some courses at the University of Texas at Arlington.

This release is production, and is available from sources on the UTA network. Please ask your professor for the link. (3.8 GB, MD5 is 5c47ed9f4976f5fb2cda06e5e2eceb06)

[A video is available](https://youtu.be/0dK8MEktWSk) to walk you through importing and running this virtual machine on your laptop or desktop computer.

After download and before importing, verify the MD5 checksum from your operating system's command line, shown below by host. **If the checksums do not match, the imported virtual machine will be unstable.** Download again, or obtain a valid copy from a known good source.

* Linux:    **``md5sum cse-vm-3.1.2.ova``**
* Mac OS X: **``md5 cse-vm-3.1.2.ova``**
* Windows:  **``CertUtil -hashfile cse-vm-3.1.2.ova MD5``**

## Identification

As of version 3.1.2, this virtual machine name is CSE-VM, and the release name is CSE-VM-3.1.2. 

An instructor may customize this release by importing the .ova file into VirtualBox, making changes, and exporting a new .ova file, which should be named with the course and section (and optional version) appended, e.g., CSE-VM-3.1.2-CSE1325-001.ova.

Major version numbers correspond to the underlying Ubuntu Long Term Support (LTS) release: 1.x was built on Lubuntu 16.04, 2.x was built on Lubuntu 18.04, and 3.x is built on Xubuntu 20.04.

> The switch to Xubuntu reflects the rewrite of the LDXE desktop on which Lubuntu is built, from Gtk+ to Qt, leading to concern over possible stability issues. Xfce, on which Xubuntu is based, is Gtk+ based (currently used for CSE1325), lightweight, and stable.

Minor version numbers indicate the semester for which that virtual machine is intended. 3.0 indicates fall of 2020, 3.1 spring of 2021, 3.2 fall of 2021, and 3.3 spring of 2022. Fall of 2022 will then move to the next LTS release, 22.04, as version 4.0, with whatever desktop seems most advantageous at that time.

## Configure Host System

To use this release, install VirtualBox and use File > Import Appliance, specifying the downloaded CSE-VM-3.1.2.ova file.

The process to rebuild this release from publicly available packages is detailed starting here.

This release of CSE-VM is built on an x64 Ubuntu 20.04 host system, although a Windows 10 or Mac OS X host should work as well. This release has been tested under Ubuntu 20.04 and Windows 10.

1. Install the latest version of Oracle VirtualBox from [the VirtualBox website](https://www.virtualbox.org/). 

## Create a Xubuntu 20.04 Virtual Machine

NOTE: Oracle changes the VirtualBox interface regularly. These instructions are based on VirtualBox 6.1.6_Ubuntu r137129.

[Download Xubuntu 20.04](https://xubuntu.org/download/). The filename should be xubuntu-20.04-desktop-amd64.iso, and is close to 2 GB in size. (NOTE: Pre-patched releases are occasionally made, so use e.g., 20.04.1 if available.)

1. Launch VirtualBox.
2. Select Machine -> New...
3. In the Create Virtual Machine dialog, select a name (see [Identification](#identification)) and set Type to Linux, Version to Ubuntu (64-bit), Memory Size to 2048 MB, and Hard Disk to Create a Virtual Hard Disk Now. Click Create.
4. In the Create Virtual Hard Disk dialog, set File Size to at least 15 GB, File Type to VDI, and Storage to Dynamically Allocated. Click Create. You should see your new VM in the list in the VirtualBox Manager main window, marked as Powered Off.
5. Select your new VM and click Settings. Accept all defaults except for the following changes.
    * Under General -> Advanced, enable Shared Clipboard.
    * Under Display -> Screen, set Video Memory to 128 MB and Video Controller to VBoxSVGA. Ignore the warning about the video configuration; this is the correct configuration.
    * Under Storage -> Storage Devices -> Controller:IDE, select Empty. Click the CD icon under Attributes and select Choose a Disk File. Select xubuntu-20.04-desktop-amd64.iso (or a later patch release) from the host file system.
6. Accept the Settings changes, then click Start to launch the new virtual machine. In the Select Start-up Disk dialog, select xubuntu-20.04-desktop-amd64.iso (or a later patch release). Click Start. You should see the Xubuntu logo and some scrolling status messages as the operating system boots into the virtual machine. Patience.
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

1. [Install the following packages](#how-to-install-packages) to better integrate Xubuntu with the host system: **virtualbox-ext-pack gnome-tweaks**
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

If you look through the list, you should see ``xfce4-popup-whiskermenu`` in the alphabetized Command column, with ``Super L`` associated with it in the Shortcut column. If not, retrace the above steps in this section more carefully.

## Usability Package Installations

Install the following packages.

1. Install the following packages to support the 'div' script: ``figlet boxes lolcat``
3. Install the following package to support locating files anywhere by name fragment: ``mlocate``
3. Install the following package to support searching PDFs, e.g., lecture notes: ``pdfgrep``
4. Install the following packages for quick screenshots: ``scrot gnome-screenshot``

## Manual Program Installations

A few executables are not available in the system repository, but can be added to the /home/student/bin directory. NOTE: Ubuntu will automatically detect this directory and add it to the student's path each time bash is launched.

1. Create directory ~/bin using this bash command: ``mkdir ~/bin``  
2. Add the [following executable](https://the.exa.website/install) to bin to support the lt and lx directory listers: ``exa``
3. Add the [following JAR file](https://plantuml.com/download) to bin to support UML diagram generation: ``plantuml.jar``
4. Install the following GraphViz package, on which PlantUML relies: ``graphviz``
5. Add the following script to bin to run Plant UML as an executable (use ``chmod a+x plantuml`` to make it executable): ``plantuml``

         #!/usr/bin/env bash
         /usr/bin/java -jar /home/student/bin/plantuml.jar $@

## Popular Editor Installations

Xubuntu defaults to Mousepad, a perfectly reasonable Notepad equivalent. Some students want... more.

1. Install the two gedit packages as a more capable replacement for mousepad as default editor: ``gedit gedit-plugins``
2. Open gedit by typing ``gedit``. Click gear > Preferences > Editor. Disable "Use spaces insead of tabs" (required to edit a Makefile). Close gedit.
3. Install Code::Blocks as an optional editor: ``codeblocks``
4. Use this command to install Visual Studio Code as an optional editor, which can then be launched as ``code``: ``sudo snap install --classic code``
5. Select Start > Settings > MIME Type Editor. For source code types text/x-c++hdr, text/x-c++src, text/x-java, and text/x-python, double-click the Default Application cell and select Text Editor (this is gedit).
5. Add the snap binary directory to PATH by adding the following lines to: ``gedit .profile``

```
# set PATH so it includes /snap/bin if it exists
if [ -d "/snap/bin" ] ; then
    PATH="/snap/bin:$PATH"
fi
```

## Development Package Installations

1. Install the following package to provide developer documentation: ``devhelp``
2. Install the following package to support C/C++ development: ``build-essential``
3. Install the following packages to support C++ GUI development (the -doc versions add documentation to devhelp): ``libgtkmm-3.0-dev libgstreamermm-1.0-dev libgtkmm-3.0-doc libgstreamermm-1.0-doc``
4. Install the following package to support Java development: ``openjdk-14-jdk``
    1. Select Java 14 as default from the menu (it will likely report "only one alternative", which is success): ``sudo update-alternatives --config java``
    2. Add JAVA_HOME to the environment by adding ``JAVA_HOME="/usr/lib/jvm/java-14-openjdk-amd64"`` to this file: ``sudo gedit /etc/environment``
5. Python 3 is preinstalled, but install the following package to manage Python plug-ins: ``python3-pip``
6. Install the following package to support debugging and profiling Linux programs: ``valgrind``
7. Install the following package to support version control (or install ``git-all``, if a stand-alone GUI is also desired): ``git``
8. Install the following package to support visual differencing and merging: ``meld``
9. Install the following package to support counting lines of code: ``cloc``

## Update .bashrc

Edit ~/.bashrc so that the bash prompt ends in a neutrally-colored $ when the previous command concluded successfully, but in a red @ when the previous command failed. (This helps to teach students why returning an int from main is important.)  Replace this line:

``PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '``

with

``PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$( [ $? == 0 ] && echo "\$ " || echo "\[\033[1;31m\]@ \[\033[00m\]" '``

## Add .bash_aliases

Add a .bash_aliases to the home directory, i.e., ~/.bash_aliases.  The content of this file is in this repository as bash_aliases (note the missing leading dot, which you must add after copying). It may be tweaked by a competent bash developer, or by students after importing the appliance. 

(NOTE: When bash launches, the .bashrc script is run, and it will automatically execute .bash_aliases if it exists.)

## Add .gitconfig

Add a .gitconfig to the home directory, i.e., ~/.gitconfig.  The content of this file is provided in this repository as gitconfig (note the missing leading dot, which you must add after copying). It may be tweaked by a competent git guru, or by students after importing the appliance. 

(NOTE: When git first launches, it will ask for the student's name and email and add them to .gitconfig.)

## Reduce the size of the OVA file

The end of following article offers more comprehensive advice on reducing the size of an OVA file.

https://technology.amis.nl/platform-technology/virtualization-and-oracle-vm/ubuntu-vm-virtualbox-increase-size-disk-make-smaller-exports-distribution/

The following simpler process reduces the size by about 5%.

1. Install BleachBit: ``sudo apt install bleachbit``
2. Run BleachBit as root: ``sudo bleachbit``
3. Enable every option except System > Memory
4. Click Clean. This may take awhile, so prepare and drink your favorite beverage.

## Export

Exporting the new virtual machine to a .ova file simplifies distribution to students.

Be sure the virtual machine is configured the way you want it to boot first for the students. Disconnect any shared drives. Changed to windowed rather than full screen mode. Ensure the user to auto-login in student, and that the password is student (they can change it after importing the appliance).

1. In the VirtualBox main window select File -> Export Appliance. 
2. Select the OVF 1.0 format and click Next. 
3. Complete the product information. Do NOT specify a license. (Note that if any license is specified, then the students will be asked to accept that license.)
4. Click Export. This may take some time. Patience.

## Appendix A

Copy the ``bash_aliases`` file into the student home directory of the virtual machine as file .bash_aliases. This file, along with the configuration documented above, adds the following bash commands to assist the students.

* **e hello.cpp** – Opens the file(s) in each associated default editor (works with .pdf, .png, .jpg... all associated types!). Note that other editors may be invoked manually, e.g.,
    * **vi hello.cpp** – Opens the file(s) in vim light (use ``sudo apt install vim`` for full vim)
    * **gedit hello.cpp** – Opens the file(s) in gedit
    * **code hello.cpp** – Opens the file(s) in Visual Studio Code
    * **codeblocks hello.cpp** – Opens the file(s) in Code::Blocks
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

> In XUbuntu 20.04, xdg-open inexplicably fails to launch gedit. Therefore, the e() function in this file has special code to detect key files and open them directly in gedit. This code is a work-around, and should be removed once Canonical fixes this bug.

## Appendix B

Copy the ``gitconfig`` file into the student home directory of the virtual machine as file .gitconfig. This file preconfigures git to operate conveniently, with colorful output, caching the GitHub credentials, setting difftool and mergetool to use meld, and adding a couple of aliases.

NOTE: Permanently caching the student's GitHub credentials is very convenient but assumes the student's laptop is protected, as these credentials are stored as a plain text file in the VM. To save the credentials only in memory and for a limited time (in this case, 8 hours), replace the credentials section with:

```
[credential]
    helper = cache --timeout 28800
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




