#!/bin/bash

# PR commit-message
PR_COMMIT_MESSAGE="Auto-format functionality (Terraform file linting)"
echo "::set-output name=commit-message::$(echo $PR_COMMIT_MESSAGE)"

# PR body
PR_BODY="This auto-generated PR ensures that the formatting of all Terraform files present in the repo is uniform."
echo "::set-output name=pr-body::$(echo $PR_BODY)"

# PR labels
PR_LABELS="automated pr,no-release"
echo "::set-output name=pr-labels::$(echo $PR_LABELS)"
