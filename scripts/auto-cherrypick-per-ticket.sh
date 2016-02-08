#!/bin/bash
# retrieve all the commits associated to a given TMCORE ticket and cherry-pick them in the correct order to the local branch
# c.f. https://stackoverflow.com/questions/28735942/git-cherry-pick-those-commits-that-contain-a-keyword-tracking-id
# usage: ./$0 17299

git log --reverse --no-merges --pretty=%H --grep="TMCORE-${1}" develop | while read rev
do
	echo "cherry pick now $rev"
	git cherry-pick $rev
	RC=$?
	if [ ! $RC -eq 0 ]; then 
		echo "cherry pick failed with error ${RC} - skip it"
		git cherry-pick --abort
	fi
done;
