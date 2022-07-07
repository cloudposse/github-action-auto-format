#!/bin/bash

# PR commit-message
PR_COMMIT_MESSAGE="Automated update of context.tf"
echo "::set-output name=commit-message::$(echo $PR_COMMIT_MESSAGE)"

# PR body
PR_BODY="This auto-generated PR updates this repo's `context.tf` file to be in sync with the newest `context.tf` found in the `cloudposse/terraform-null-label` repo"
echo "::set-output name=pr-body::$(echo $PR_BODY)"

# PR labels
PR_LABELS="automated pr"
echo "::set-output name=pr-labels::$(echo $PR_LABELS)"

# PR title
PR_TITLE="Automated update of context.tf"
echo "::set-output name=pr-title::$(echo $PR_TITLE)"
