#!/bin/bash

if [[ "$HOST_REPO" == "cloudposse/github-action-terraform-auto-context" ]]; then
  mv ./test/context.tf .
  echo "Moved context.tf to top-level directory."
fi

git config --global --add safe.directory /github/workspace
if [[ -f context.tf ]]; then
  echo "Discovered existing context.tf!"
  echo "Checking for pre-existing ${BRANCH_NAME} branch."
  if [[ ! $(git show-branch remotes/origin/${BRANCH_NAME}) ]]; then
    echo "Branch ${BRANCH_NAME} not found."
    echo "Fetching most recent version of context.tf to see if there is an update."
    curl -o context.tf -fsSL https://raw.githubusercontent.com/cloudposse/terraform-null-label/master/exports/context.tf
    if [[ $(git diff --no-patch --exit-code context.tf) ]]; then
      echo "No changes detected! Exiting the job..."
    else
      # updating context.tf
      echo "context.tf has changed. Update it and commit the updated context.tf to a new ${BRANCH_NAME} branch."
      make github/init/context.tf
      # The above make target adds a .build-harness file. Hopefully, no repository that runs this action actually wants to keep its .build-harness file.
      rm .build-harness
    fi
  else
    echo "Branch ${BRANCH_NAME} found."
    echo "Please merge or delete pre-existing ${BRANCH_NAME} branch before rerunning this action."
  fi
else
  echo "This module has not yet been updated to support the context.tf pattern! Please update in order to support automatic updates."
fi

if [[ "$HOST_REPO" == "cloudposse/github-action-terraform-auto-context" ]]; then
  mv context.tf ./test/
  echo "Moved context.tf back to ./test/ directory."
fi
