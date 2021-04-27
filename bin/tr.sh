#!/bin/bash


# Dependencies:
# bash, which, find,  grep, sort, xargs, shasum,  getopts
WHICH="/usr/bin/which"
FIND=$($WHICH find)
GREP=$($WHICH grep)
SORT=$($WHICH sort)
XARGS=$($WHICH xargs)
SHASUM=$($WHICH shasum)
[ -z "$SHASUM" ] && SHASUM=$($WHICH sha1sum)


if [ -z "$WHICH" ] ||
   [ -z "$FIND" ] ||
   [ -z "$GREP" ] ||
   [ -z "$SORT" ] ||
   [ -z "$XARGS" ] ||
   [ -z "SHASUM" ]; then
   echo "Dependicies not fullfilled, look for no string after ="     
   echo "which=$WHICH"
   echo "find=$FIND"
   echo "grep=$GREP"
   echo "sort=$SORT"
   echo "xargs=$XARGS"
   echo "shasum=$SHASUM"
   exit 1
fi


# A POSIX variable
OPTIND=1         # Reset in case getopts has been used previously in the shell.

# Initialize our own variables:
exclude_file=""
verbose=0

show_help() {
    echo "Usage: $0 [options] [path]"
    echo
    echo "$0 traverses all files and directories under path"
    echo "and calculate one shasum for each directory and its files"
    echo "and one shasum for the path itself."
    echo "If path is left out current directory is used."
    echo 
    echo "Options:"
    echo "-h -> show this help and exit"
    echo "-e file -> file contains a list of  directories to exclude"
    echo "-v -> verbose, produce som info text."
}

cwd=$(pwd)


while getopts "h?ve:" opt; do
    case "$opt" in
    h|\?)
        show_help
        exit 0
        ;;
    v)  verbose=1
        ;;
    e)  exclude_file="$(cd "$(dirname "$OPTARG")"; pwd -P)/$(basename "$OPTARG")"
	if [ ! -f "$exclude_file" ]; then
	    echo "Exclude file: ${exclude_file} does not exist!"
	    exit 1
	fi    
        ;;
    esac
done

shift $((OPTIND-1))

[ "${1:-}" = "--" ] && shift

[ "$verbose" != "0" ] && echo "verbose=$verbose, exclude_file='$exclude_file', Leftovers: $@, $# , $1"


if [ -d "$1" ]; then
    if [ "$verbose" != "0" ]; then
	echo "Change to directory: $1"
    fi
    cd "$1"
fi

for filename in *; do
    if [ -d "$filename" ]; then
	[ "$verbose" != "0" ] && echo "Found directory: $filename"
	if [ ! -z "$exclude_file"  ]; then
	    [ "$verbose" != "0" ] && echo " Test for exclusion"
            found=$(${GREP} "$filename" "$exclude_file")
            if [ ! -z "$found" ]; then
		# If found then skip
		[ "$verbose" !=  "0" ] && echo  "  Exclude $filename"
		continue
            fi
	else
	    [ "$verbose" != "0" ] && echo "exlusion file: $exclude_file doesn't exist"
	fi
    
	cd  "$filename"
	printf "$filename --> "
	res="0"
	res=$(${FIND} . -type f -print0 | ${SORT} -z | ${XARGS} -0 ${SHASUM} | ${SORT} | ${SHASUM})
	cd ..
	printf "$res\n"
    fi	
done

res="0"
res=$(${FIND} .  -maxdepth 1 -type f -print0 | ${SORT} -z | ${XARGS} -0 ${SHASUM} | ${SORT} | ${SHASUM})
filename=$(pwd)
echo "$filename --> $res"
cd "$cwd"




