#!/bin/bash

TEST_FOLDER="./scripts/terraform/test/"
if [[ "$HOST_REPO" == "cloudposse/github-action-auto-format" ]]; then
  mv ${TEST_FOLDER}*.tf .
fi

make BUILD_HARNESS_PATH=/build-harness PACKAGES_PREFER_HOST=true -f /build-harness/templates/Makefile.build-harness terraform/fmt

if [[ "$HOST_REPO" == "cloudposse/github-action-auto-format" ]]; then
  mv ./*.tf ${TEST_FOLDER}
fi

set -x

output=$(git diff --name-only)
if [ -n "$output" ]; then
  echo "Changes detected. Pushing to the PR branch"
  git add -A -- ':!'"${IGNORE_PATH}"''
  git commit -m "Auto formatting Terraform files"
else
  echo "No changes detected"
fi
