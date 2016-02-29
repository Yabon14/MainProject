#!/bin/sh
# Automatically merge the last commit through the following branches:
# 2.1 -} 2.2 -} 2.3 -} master

CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
LAST_COMMIT=$(git rev-list -1 HEAD)

echo Automatically merging commit $LAST_COMMIT from $CURRENT_BRANCH rippling to master

# git checkout develop-cityA
# git merge develop
# git commit -m 'merge develop'

# git checkout develop-cityB
# git merge develop
# git commit -m 'merge develop'

# git checkout develop


for REMOTE in `git branch --list`
do 
if [[ $REMOTE == *"/develop"* ]]
then
  echo "It's there: $REMOTE";
  git checkout $REMOTE
  git merge develop
  git commit -m 'merge develop'
fi
done


git checkout develop
