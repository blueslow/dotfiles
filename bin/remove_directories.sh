#!/bin/sh


if [ "$1" != "" ] && [ -f $1 ] 
then
    cat $1 | while read line 
    do
	if [ "$line" != "" ] && [ -d "$line" ]
	then
	    echo "Tar bort $line"
            rm -rf "$line"
	fi
    done
else
    echo "Remove directories and files even in subdirectories"
    echo "Usage:"
    echo "$0 directories_to_be_deleted"
    echo "directories_to_be_deleted - The file contains one directory per line to be deleted, e.g. created by ls -1."
fi

