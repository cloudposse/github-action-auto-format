#!/bin/bash

if [[ "$HOST_REPO" == "cloudposse/github-action-auto-format" ]]; then
  mv ./test/*.tf .
fi

make BUILD_HARNESS_PATH=/build-harness PACKAGES_PREFER_HOST=true -f /build-harness/templates/Makefile.build-harness terraform/fmt

if [[ "$HOST_REPO" == "cloudposse/github-action-auto-format" ]]; then
  mv ./*.tf ./test/
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
