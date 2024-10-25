#!/bin/bash

show_usage() {
    echo "Usage: $(basename $0) <branch_name>"
    echo "Example: $(basename $0) feature-add-login"
    exit 1
}

if [ $# -eq 0 ]; then
    echo "Error: Branch name is required"
    show_usage
fi

branch_name="$1"
commit_message="$1"

echo "Creating new branch: $branch_name"
git checkout -b "$branch_name"

echo "Adding all changes"
git add .

echo "Committing with message: $commit_message"
git commit -m "$commit_message"
git push origin HEAD

echo "Done"!
