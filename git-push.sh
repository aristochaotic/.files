#!/bin/bash
if [[ "$#" -ne 2 ]]; then
	printf "Usage: %s <commit-message>\n" "$0"
	exit 1
fi

cd "$1"
git add .
git commit -m "$2"
git push
cd -