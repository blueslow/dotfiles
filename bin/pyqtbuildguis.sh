#! /bin/bash

# Convert qt designer  ui (xml) files to python files
PYUIC=/usr/bin/pyuic4 # Converter program

# Changes bash separator to new line only, but save
# current setting so it can be restored. In order to handel filenames
# with spaces
OFS=$IFS
IFS=$'\n'

# Find all .ui files in directory
files="$(ls -1A *.ui)"

#Convert file if ui file is newer than python file or python file doesn't exist
for src in $files
do
	dest=${src%.ui}Gui.py
	if [[ $src -nt $dest ]]; then
		#src is newer then $dest
		$PYUIC -o $dest $src
	fi
done
IFS=$OFS # restore
