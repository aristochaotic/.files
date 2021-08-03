#!/bin/bash
#rturn error if commit-message is wrong
if [[ "$#" -ne 2 ]]; then
	printf "Usage: %s <commit-message>\n" "$0"
	exit 1
fi

#move to the dir wit git
cd "$1" || exit
git add .
git commit -m "$2"
git push
#moves back to the prevus dir
cd - || exit