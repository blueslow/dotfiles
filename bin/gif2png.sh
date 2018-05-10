#! /bin/bash

echo converts all non animated gif files in  a directory to png
echo the gif files also remains

files=$(ls -1A *.gif)
echo $files

for file in $files
do
    dest=$(basename $file .gif).png
    echo "$file -> $dest"
    convert $file $dest
done

  
