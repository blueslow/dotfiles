#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

git pull origin master;

function doIt() {
	# Files and directories to exclude
	EXC="--exclude .git/"
	EXC=${EXC}" --exclude .DS_Store"
	EXC=${EXC}" --exclude .osx"
	EXC=${EXC}" --exclude bootstrap.sh"
	EXC=${EXC}" --exclude README.md"
	EXC=${EXC}" --exclude LICENSE-MIT.txt"
	EXC=${EXC}" --exclude todo.md"
	EXC=${EXC}" --exclude installed_by_klaseh_jawa.txt"
	EXC=${EXC}" --exclude installed_by_root_jawa.txt"

	UNAME=$(uname)
	if [ "$UNAME" == "Linux" ] ; then
		# Linux specific things
		EXC=${EXC}" --exclude .Darwin_specific"
		EXC=${EXC}" --exclude brew.sh"
		EXC=${EXC}" --exclude init/"
	elif [ "$UNAME" == "Darwin" ] ; then
		# Mac OS X specific things
		EXC=${EXC}" --exclude init/"
	elif [ "$UNAME" == "FreeBSD" ] ; then
		# FreeBSD specific things
		EXC=${EXC}" --exclude .Darwin_specific"
		EXC=${EXC}" --exclude brew.sh"
		EXC=${EXC}" --exclude init/"
	elif [[ "$UNAME" == CYGWIN* || $UNAME = MINGW* ]] ; then
		# Windows specific things, may need more test above
		EXC=${EXC}" --exclude .Darwin_specific"
		EXC=${EXC}" --exclude brew.sh"
		EXC=${EXC}" --exclude init/"
	fi

	EXC=${EXC}" -avh --no-perms"
	rsync ${EXC} . ~/apa;
	source ~/.bash_profile;

}

# function doIt1() {
# 	EXC="--exclude .git/"
# 	EXC=${EXC}" --exclude .DS_Store"
# 	EXC=${EXC}" --exclude .osx"
# 	EXC=${EXC}" --exclude bootstrap.sh"
# 	EXC=${EXC}" --exclude README.md"
# 	EXC=${EXC}" --exclude LICENSE-MIT.txt"
# 	EXC=${EXC}" --exclude todo.md"
# 	UNAME=$(uname)
# 	if [ "$UNAME" == "Linux" ] ; then
# 		# Linux specific things
# 		EXC=${EXC}" --exclude .Darwin_specific"
# 		EXC=${EXC}" --exclude brew.sh"
# 		EXC=${EXC}" --exclude init/"
# 	else
# 		EXC="apa"
# 	fi
#
# 	EXC=${EXC}" -avh --no-perms"
#
# 	echo ${EXC}
# }


if [ "$1" == "--force" -o "$1" == "-f" ]; then
	doIt;
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt;
	fi;
fi;
unset doIt;
