#! /bin/bash

[ -z "$1" ] && echo "wrong para " && exit
cd $1
repo="pgit@derbi.sehlstedt.se:"$1".git"
echo "Processing $1 to new repo at $repo"
git branch -a -vv
git remote -v
echo  " "
echo "Add temporary new repository, must exist (bare)"
git remote add norigin $repo
git branch -a -vv
git remote -v
echo " "
echo  "Now add  refs and tags"
git push norigin refs/remotes/origin/*:refs/heads/*
git push --tags  norigin 
echo " "
echo  "Result: "
git branch  -a -vv
git remote -v
echo "Set new origin and remove the temporary new origin"
git remote set-url origin $repo
git remote rm norigin
git branch -a -vv
git remote -v
