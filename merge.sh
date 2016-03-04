#!/bin/sh
# Automatically merge the develop branch into all target/<city>/develop
# Automatically cancel the merge if there is conflicts

CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
LAST_COMMIT=$(git rev-list -1 HEAD)


for REMOTE in `git branch --list`
do 
  if [[ $REMOTE == *"/develop"* ]]
  then
    # echo "It's there: $REMOTE";
    git checkout $REMOTE

    MERGE_RESULT="result"

    if [[ $REMOTE == *"cityB/develop"* ]] 
    then
      MERGE_RESULT=$(git merge -s ours develop)
    else
      MERGE_RESULT=$(git merge develop)
    fi

    echo "Merge result is $MERGE_RESULT"
    
    if [[ $MERGE_RESULT != *"Updating"* ]] 
    then
      echo "*****************************************************************"
      echo "*** Conflict with branch $REMOTE, please merge manually ***"
      echo "*****************************************************************"
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

