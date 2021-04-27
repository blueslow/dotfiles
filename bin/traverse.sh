#!/bin/bash
cmd='find . -type f -print0 | sort -z | xargs -0 sha1sum | sha1sum'
for f in *; do
    if [ -d "$f" ]; then
        grep  -q "$f" ~/tmp/skip.txt
        status=$?
        if [ $status -eq 0 ]; then
            # If found then skip
            # echo  "Skipping  $f"
            continue
        fi
        cd  "$f"
        printf "$f --> "
        res="0"
        res=$(find . -type f -print0 | sort -z | xargs -0 sha1sum | sha1sum)
        cd ..
        printf "$res\n"
    fi
done
res=$(find .  -maxdepth 1 -type f -print0 | sort -z | xargs -0 sha1sum | sha1sum)
f=$(pwd)
echo ". --> $res"
