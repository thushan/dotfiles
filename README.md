# Thushan Fernando's dotfiles

This repository contains my configuration files and scripts for my `$HOME` as well as default applications I tend to install.

# Operating System Specific Things

There are some OS specific things in operating system specific folders.

## macos

Mac OS X specific configuration, default `brew` packages & tweaks made on a fresh install.

- [default.sh](macos/default.sh) - Default settings for a fresh install.
- [install-brew.sh](macos/install-brew.sh) - Installs brew packages passing in the package list which is contained within the script itself.

The scripts are tested using the excellent [macos-Simple-KVM](https://github.com/foxlet/macOS-Simple-KVM) before being rolled into a new image.

## linux

The Linux repo's are broken down into distro specifics. My journey has been Debian (2003+), Ubuntu (2007-2009), Debian again, then Mint and now PopOS & Fedora.

- [default.sh](linux-popos/default.sh) - Default settings for gnome/environment on popos
- [install-apt.sh](linux-popos/install-apt.sh) - Installs default packages from apt
- [install-flatpaks.sh](linux-popos/install-flatpaks.sh) - Installs default packages from flatpaks.

Similar process/scripts for `linux-fedora` (except `dnf`).

## windows

A handful of choco scripts and my [Windows Terminal](https://github.com/thushan/dotfiles/blob/main/windows/windows-terminal/settings.json) profile are found in there.

Only really use Windows (10) for work so this doesn't get much love anymore.

# Acknowledgements

There has been numerous places the source for the content within this repo was taken from, most are attributed with an 'src' tag somewhere (be it a forum, reddit post etc). 

But most recently, some of the configuration items are heavily influenced by:

* [kentcdodds/dotfiles](https://github.com/kentcdodds/dotfiles)
* [mathiasbynens/dotfiles](https://github.com/mathiasbynens/dotfiles)
* [cgit/dotfiles](https://dev.sanctum.geek.nz/cgit/dotfiles.git/about/)