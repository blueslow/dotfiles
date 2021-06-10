#! /bin/bash

[ -z "$1" ] && echo "wrong para " && exit
cd $1
res=$?
if [ "$res" = "1" ]; then
    echo "Directory $1 does not exist, exiting"
    exit $res
fi
# Get the path of current directory
CD=$(pwd)
if [ ! -d "$CD/.git" ]; then
    echo  "Directory is not git directory, exiting"
    exit 1
fi

# Get the name of the simple git directory name
# by moving up to parent directory
cd ..
REMOVEPATH=$(pwd)
cd $CD
# Remove all prefix directories just leaving the name of current directory
# e.g. the repository name
TRIMMED=${CD#$REMOVEPATH}
# Remove inititial / (slash)
TRIMMED=$(echo "$TRIMMED" | sed 's:^/::' )

NEWREPO="ssh://git@rex.sehlstedt.se:3022/klaseh/"$TRIMMED".git"
echo "Processing $CD to new repo at $NEWREPO"

git branch -a -vv
git remote -v
echo  " "
echo "Add temporary new repository, must exist (bare)"
git remote add neworigin $NEWREPO
git branch -a -vv
git remote -v
echo " "
echo  "Now add  refs and tags"
git push neworigin refs/remotes/origin/*:refs/heads/*
# git push neworigin --all
git push neworigin  --tags
echo " "
echo  "Result: "
git branch  -a -vv
git remote -v
echo "Set new origin and remove the temporary new origin"
git remote set-url origin $NEWREPO
git remote rm neworigin
git branch -a -vv
git remote -v
