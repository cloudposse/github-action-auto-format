#!/bin/bash

# PR commit-message
PR_COMMIT_MESSAGE="Auto-format functionality (.github files updating)"
echo "::set-output name=commit-message::$(echo $PR_COMMIT_MESSAGE)"

# PR body
PR_BODY="This auto-generated PR adds standard files from the `cloudposse/.github` repo to this repo's `.github` folder"
echo "::set-output name=pr-body::$(echo $PR_BODY)"

# PR labels
PR_LABELS="automated pr,no-release"
echo "::set-output name=pr-labels::$(echo $PR_LABELS)"
