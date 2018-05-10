#!/bin/bash
echo Creates a remote git repository on aprilia from an existing
echo local git project.
echo First parameter is the name of the local git project
echo Second parameter is subpath on the remote, is optional.
echo Note subpath must exist.
if [ $# -eq 0 ]
 then
    echo No parameters given, exiting.
    exit 1
fi

echo Local git project $1 will be created as remote repo $1.git
echo in subtree $2

if [ -z "$2" ]
 then
    dest="pgit@aprilia.sehlstedt.se:/home/pgit/."
    clone="pgit@aprilia.sehlstedt.se:/home/pgit/"$1.git
else
    dest="pgit@aprilia.sehlstedt.se:/home/pgit/$2/."
    clone="pgit@aprilia.sehlstedt.se:/home/pgit/$2/"$1.git
fi

git clone --bare $1 $1.git

ssh klaseh@aprilia bin/en_pgit
echo Copying bare git to $dest
scp -r $1.git $dest
ssh klaseh@aprilia bin/di_pgit
read -p "Press [Enter] to continue"

rm -rf $1.git
mv $1 $1.old
/usr/bin/git clone $clone $1
