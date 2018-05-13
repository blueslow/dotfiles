#!/bin/sh


if [ "$1" != "" ] && [ -f $1 ] 
then
    cat $1 | while read line 
    do
	if [ "$line" != "" ] # && [ -f "$line" ]
	then
  	    echo "Tar bort $line"
            rm -rf "$line"
	fi
    done
else
    echo "Remove files listed in the file"
    echo "Usage:"
    echo "$0 files_to_be_deleted"
    echo "files_to_be_deleted - The file contains one filename per line to be deleted."
fi

