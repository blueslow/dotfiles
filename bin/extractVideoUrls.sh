#! /bin/bash
# Get full filename without path
ffn=$(basename -- "$1")
# Get file extension
ext="${ffn##*.}"
# Get file name
fn="${ffn%.*}"
# Create otput file name
ofn=$fn".txt"
pfn=$fn".ptxt"
# create a temp file that is removed when process close
tfn=$(mktemp)
exec 3>"$tfn"
rm "$tfn"
# Extract urls for videos, write to temporary file
grep \"video\"\:\ \" $1 | sed 's/\t*"video": //g ; s/"//g ;  s/,//g' >"$tfn"
# grep video $1 | sed 's/^[ \t]*"video": "//g'|sed 's/",$//g'>"$tfn"
# Get rid of urls to containing playlist, e.g. urls for further processing
grep -v playlist "$tfn" > $ofn
# Get the unique urls that only contains playlist, e.g. urls for further processing
grep playlist "$tfn" | sort | uniq > $pfn
# grep playlist "$tfn" > $pfn
rm $tfn
