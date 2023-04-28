#!/bin/bash

# PR commit-message
PR_COMMIT_MESSAGE="Automated update of .github files"
echo "commit-message=$(echo $PR_COMMIT_MESSAGE)" >> $GITHUB_OUTPUT

# PR body
PR_BODY="This auto-generated PR adds standard files from the `cloudposse/.github` repo to this repo's `.github` folder"
echo "pr-body=$(echo $PR_BODY)" >> $GITHUB_OUTPUT

# PR labels
PR_LABELS="automated pr,no-release"
echo "pr-labels=$(echo $PR_LABELS)" >> $GITHUB_OUTPUT

# PR title
PR_TITLE="Automated update of .github files"
echo "pr-title=$(echo $PR_TITLE)" >> $GITHUB_OUTPUT
