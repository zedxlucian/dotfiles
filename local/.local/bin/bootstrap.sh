#!/usr/bin/env bash

### OPTIONS AND VARIABLES ###

DOTFILESREPO="https://github.com/zedxlucian/dotfiles.git"
AURHELPER="yay"
REPOBRANCH="master"
PACKAGES="/tmp/packages"

### FUNCTIONS ###

installpkg() { pacman --noconfirm --needed -S "$1" >/dev/null 2>&1 ;}

error() { clear; printf "ERROR:\\n%s\\n" "$1"; exit 1;}


gitconfig () { \
    echo "Adding git credentials globally"
	sudo -u lydien git config --global user.email "s.lydien@icloud.com"
	sudo -u lydien git config --global user.name "Lydien Sandanasamy" ;}

refreshkeys() { \
    echo "Refreshing archlinux-keyring"
	pacman --noconfirm -Sy archlinux-keyring >/dev/null 2>&1
	}

newperms() { # Set special sudoers settings for install (or after).
    echo "Setting permissions"
	echo "$* " >> /etc/sudoers ;}

manualinstall() { # Installs $1 manually if not installed. Used only for AUR helper here.
    echo "Installing yay"
	[ -f "/usr/bin/$1" ] || (
	cd /tmp || exit
	rm -rf /tmp/"$1"*
	curl -sO https://aur.archlinux.org/cgit/aur.git/snapshot/"$1".tar.gz &&
	sudo -u "lydien" tar -xvf "$1".tar.gz >/dev/null 2>&1 &&
	cd "$1" &&
	sudo -u "lydien" makepkg --noconfirm -si >/dev/null 2>&1
cd /tmp || return) ;}

maininstall() { # Installs all needed programs from main repo.
    echo "Installing $n of $total from MAIN"
	installpkg "$1"
	}

gitmakeinstall() {
	progname="$(basename "$1" .git)"
	repodir="/home/lydien/.local/src"; mkdir -p "$repodir"; chown -R lydien:wheel "$(dirname "$repodir")"
	dir="$repodir/$progname"
    diffdir=""$repodir"/suckless/"$progname"_diffs"
	sudo -u "lydien" git clone --depth 1 "$1" "$dir" >/dev/null 2>&1 || { cd "$dir" || return ; sudo -u "lydien" git pull --force origin master;}
	cd "$dir" || exit 1
    echo "Installing $progname"
    [ ! -d "$diffdir" ] && echo "No patches for $progname" && make >/dev/null 2>&1 && make install >/dev/null 2>&1 ||
    for i in "$diffdir"/*.diff; do
        name=$(echo "$i" | sed -e 's/\/.*\///' -e 's/\.diff//' -e "s/"$progname"_//")
        sudo -u lydien git checkout master > /dev/null 2>&1 &&
        sudo -u lydien git branch "$name" > /dev/null 2>&1 &&
        sudo -u lydien git checkout "$name" > /dev/null 2>&1 &&
        sudo -u lydien git apply "$i" > /dev/null 2>&1 &&
        sudo -u lydien git add -A >/dev/null 2>&1 && sudo -u lydien git commit -m "Feature: Add $name patch" > /dev/null 2>&1
    done
    sudo -u lydien git checkout master >/dev/null 2>&1 &&
    sudo -u lydien make clean >/dev/null 2>&1 &&
    sudo -u lydien rm -f config.h >/dev/null 2>&1 && sudo -u lydien git reset --hard master >/dev/null 2>&1
    sudo -u lydien git branch custom >/dev/null 2>&1 && sudo -u lydien git checkout custom >/dev/null 2>&1 &&
    for branch in $(git for-each-ref --format='%(refname)' refs/heads/ | cut -d'/' -f3); do
        if [ "$branch" != "master" ] && [ "$branch" != "custom" ];then
            sudo -u lydien git rebase --rebase-merges "$branch" >/dev/null 2>&1
        fi
    done
    make >/dev/null 2>&1 && make install >/dev/null 2>&1 &&
    sudo -u lydien git checkout master >/dev/null 2>&1 && sudo -u lydien git branch -D custom >/dev/null 2>&1
	}

aurinstall() { \
    echo "Installing $n of $total from AUR"
	echo "$aurinstalled" | grep "^$1$" >/dev/null 2>&1 && return
	sudo -u "lydien" $AURHELPER -S --noconfirm --needed "$1" >/dev/null 2>&1
	}

pipinstall() { \
    echo "Installing $n of $total from PIP"
	echo "$aurinstalled" | grep "^$1$" >/dev/null 2>&1 && return
	command -v pip || installpkg python-pip >/dev/null 2>&1
	yes | pip install "$1"
	}

zshconfig () {
    echo "Setting up zsh as default shell"
    chsh -s /bin/zsh "lydien" >/dev/null 2>&1
    sudo -u "lydien" mkdir -p "/home/lydien/.cache/zsh/"
    echo "export ZDOTDIR=/home/lydien/.config/zsh" > /etc/zsh/zshenv
}

installationloop() { \
	total=$(wc -l < $PACKAGES)
	aurinstalled=$(pacman -Qqm)
	while IFS=, read -r tag program ; do
		n=$((n+1))
		case "$tag" in
			"A") aurinstall "$program" ;;
			"G") gitmakeinstall "$program" ;;
			"P") pipinstall "$program" ;;
			  *) maininstall "$program" ;;
		esac
	done < "$PACKAGES" ;}

stowinstall() { 
    echo "Installing dotfiles"
    branch="$REPOBRANCH"
	dir=$(echo "$DOTFILESREPO" | cut -d. -f2 | sed "s/.*\//\/home\/lydien\//")
	sudo -u "lydien" git clone --recursive -b "$branch" --depth 1 "$1" "$dir" >/dev/null 2>&1
	sudo -u "lydien" mkdir -p "/home/lydien"/{.config,.local/{src,bin/{statusbar,newsboat},share/{xorg,gnupg}}} >/dev/null 2>&1
	cd "$dir" >/dev/null 2>&1 || exit
	sudo -u "lydien" stow -t "/home/lydien/" config home local >/dev/null 2>&1 || exit
	chown -R "lydien":wheel "$dir" >/dev/null 2>&1 ;}

### THE ACTUAL SCRIPT ###

### This is how everything happens in an intuitive format and order.

# Check if user is root on Arch distro.
[ $EUID = 0 ] || error "This script must be run as root"

# Refresh Arch keyrings.
refreshkeys || error "Error automatically refreshing Arch keyring. Consider doing so manually."

installpkg curl
installpkg base-devel
installpkg git
installpkg ntp
installpkg stow

ntpdate 0.us.pool.ntp.org >/dev/null 2>&1

[ -f /etc/sudoers.pacnew ] && cp /etc/sudoers.pacnew /etc/sudoers # Just in case

# Setup git config
gitconfig || error "Could not set git credentials globally"

# Allow user to run sudo without password. Since AUR programs must be installed
# in a fakeroot environment, this is required for all builds with AUR.
newperms "%wheel ALL=(ALL) NOPASSWD: ALL"

# Make pacman and yay colorful and adds eye candy on the progress bar because why not.
grep "^Color" /etc/pacman.conf >/dev/null || sed -i "s/^#Color$/Color/" /etc/pacman.conf
grep "ILoveCandy" /etc/pacman.conf >/dev/null || sed -i "/#VerbosePkgLists/a ILoveCandy" /etc/pacman.conf

# Use all cores for compilation.
sed -i "s/-j2/-j$(nproc)/;s/^#MAKEFLAGS/MAKEFLAGS/" /etc/makepkg.conf

manualinstall $AURHELPER || error "Failed to install AUR helper."

# Install the dotfiles in the user's home directory
stowinstall "$DOTFILESREPO" "$REPOBRANCH"

# The command that does all the installing. Reads the progs.csv file and
# installs each needed program the way required. Be sure to run this only after
# the user has been created and has priviledges to run sudo without a password
# and all build dependencies are installed.
installationloop

# Make zsh the default shell for the user.
zshconfig

# Use french layout globally and also use terminus-font for TTY.
printf "KEYMAP=fr\nFONT=ter-122n\n" > /etc/vconsole.conf

# This line, overwriting the `newperms` command above will allow the user to run
# serveral important commands, `shutdown`, `reboot`, updating, etc. without a password.
newperms "%wheel ALL=(ALL) ALL
%wheel ALL=(ALL) NOPASSWD: /usr/bin/shutdown,/usr/bin/reboot,/usr/bin/systemctl suspend,/usr/bin/wifi-menu,/usr/bin/mount,/usr/bin/umount,/usr/bin/pacman -Syu,/usr/bin/pacman -Syyu,/usr/bin/packer -Syu,/usr/bin/packer -Syyu,/usr/bin/systemctl restart NetworkManager,/usr/bin/rc-service NetworkManager restart,/usr/bin/pacman -Syyu --noconfirm,/usr/bin/loadkeys,/usr/bin/yay,/usr/bin/pacman -Syyuw --noconfirm,/usr/bin/killall,/usr/bin/local/dwmc"

clear
