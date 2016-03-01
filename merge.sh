#!/bin/sh
# Automatically merge the last commit through the following branches:
# 2.1 -} 2.2 -} 2.3 -} master

CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
LAST_COMMIT=$(git rev-list -1 HEAD)

# echo Automatically merging commit $LAST_COMMIT from $CURRENT_BRANCH rippling to master


for REMOTE in `git branch --list`
do 
  if [[ $REMOTE == *"/develop"* ]]
  then
    # echo "It's there: $REMOTE";
    git checkout $REMOTE
    MERGE_RESULT=$(git merge develop)
    echo "******************  MERGE_RESULT ********************     $MERGE_RESULT"
    if [[ $MERGE_RESULT != *"Updating"* ]] then
      echo " -- Conflict with branch $REMOTE, please merge manually --"
      for COMMIT in `git log $REMOTE --oneline`
      do
      # echo "Name of commit in branch $REMOTE:  ------------  $COMMIT"
        git commit -m 'merge develop'
        git checkout -f $COMMIT
        break
      done
    else
      git commit -m 'merge develop'
    fi
  fi
done


git checkout develop

