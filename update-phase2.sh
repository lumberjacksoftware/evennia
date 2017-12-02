#!/bin/bash
set -e

echo Checking for remotes named origin, public and upstream

if [ 2 -ne $(git remote show origin | grep -c "URL\: git\@bitbucket\.org\:jkaw\/evennia.git") ]
then
    echo Please add remote named origin with command:
    echo git remote add origin git@bitbucket.org:jkaw/evennia.git
    exit 1
fi

if [ 2 -ne $(git remote show upstream | grep -c "URL\: git\@github.com\:lumberjacksoftware\/evennia.git") ]
then
    echo Please add remote named upstream with command:
    echo git remote add upstream git@github.com:lumberjacksoftware/evennia.git
    exit 1
fi

if [ 2 -ne $(git remote show public | grep -c "URL\: https\:\/\/github.com\/evennia\/evennia.git") ]
then
    echo Please add remote named public with command:
    echo git remote add public https://github.com/evennia/evennia.git
    exit 1
fi

echo Checking for existance of branch master linked to origin/master...
if [ 1 -ne $(git branch -vv | grep -c -e "[[:blank:]]master[[:blank:]].*[[:blank:]]\[origin\/master\][[:blank:]]") ]
then
    echo master branch from origin/master doesn''t exist
    echo Use command:
    echo git checkout -b master origin/master
    exit 1
fi

echo Checking for existance of branch lumberjack linked to origin/lumberjack...
if [ 1 -ne $(git branch -vv | grep -c -e "[[:blank:]]lumberjack[[:blank:]].*[[:blank:]]\[origin\/lumberjack\][[:blank:]]") ]
then
    echo lumberjack branch from origin/lumberjack doesn''t exist
    echo Use command:
    echo git checkout -b lumberjack origin/lumberjack
    exit 1
fi

echo \*\*\* Updating all remote data...
echo
git fetch --all --prune

echo \*\*\* Updating master branch in both upstream and origin from public...
echo
git checkout master
git pull
git merge public/master
git push -u upstream
git push -u origin

echo \*\*\* Updating lumberjack from master branch...
echo 
git checkout lumberjack
git pull
git merge master
git push -u upstream
git push -u origin
