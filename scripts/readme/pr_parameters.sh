#!/bin/bash

# PR commit-message
PR_COMMIT_MESSAGE="Automated rebuild of README.md"
echo "::set-output name=commit-message::$(echo $PR_COMMIT_MESSAGE)"

# PR body
PR_BODY="This auto-generated PR updates `README.md` based on changes to `README.yaml`"
echo "::set-output name=pr-body::$(echo $PR_BODY)"

# PR labels
PR_LABELS="automated pr,no-release"
echo "::set-output name=pr-labels::$(echo $PR_LABELS)"

# PR title
PR_TITLE="Automated rebuild of README.md"
echo "::set-output name=pr-title::$(echo $PR_TITLE)"
