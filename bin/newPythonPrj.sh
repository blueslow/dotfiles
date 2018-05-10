#!/bin/bash

usage () {
  echo "Usage:"
  echo "    Creates a new git project from skeleton directory"
  echo "    $0 directoryname [modulname]"
  echo "    Directory directory name must not exist."
  echo "    If modulname is not given it will be the same as directoryname."
}

SKELETONDIR=$HOME/work/p/skeleton
if [ $# -eq 0 ]; then
  echo "No new project directory given"
  usage
  exit 1
fi

if [ -d "./$1" ]; then
  echo "Directory "./$1" allready exist"
  usage
  exit 1
fi

if [ -z $2 ]; then
  n=$1
else
  n=$2
fi

echo "Creating new git project($1) with module name ($n) from skeleton directory:"
cp -avr $SKELETONDIR $1
mv ./$1/NAME ./$1/$n
mv ./$1/$n/tests/NAME_tests.py "./$1/$n/tests/$n""_tests.py"
mv ./$1/$n/NAME.py ./$1/$n/$n.py
mv ./$1/bin/NAME ./$1/bin/$n
mv ./$1/docs/NAME ./$1/docs/$n
sed -i -e "s/projectname/"$1"/g" ./$1/setup.py
sed -i -e "s/NAME/"$n"/g" ./$1/setup.py
sed -i -e "s/NAME/"$n"/g" "./$1/$n/tests/$n""_tests.py"
sed -i -e "s/NAME/"$n"/g" "./$1/$n/__init__.py"
sed -i -e "s/NAME/"$n"/g" "./$1/$n/$n.py"

cd $1
#read -p "Press [Enter] to start continue ..."
rm -vrf .git # Remove skeletons .git in new directory
rm -v README.TXT # Remove skeletons README.txt
rm -v ./bin/newPythonPrj.sh # Remove the scriptfile
#read -p "Press [Enter] to start continue ..."
/usr/bin/git init
/usr/bin/git add .
/usr/bin/git commit -m "Initital commit - project start."
/usr/local/bin/nosetests # Run initial template tests
/usr/bin/git status
