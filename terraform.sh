#!/bin/bash

make BUILD_HARNESS_PATH=/build-harness PACKAGES_PREFER_HOST=true -f /build-harness/templates/Makefile.build-harness pr/auto-format/host

set -x

output=$(git diff --name-only)
if [ -n "$output" ]; then
  echo "Changes detected. Pushing to the PR branch"
  git config --global user.name 'cloudpossebot'
  git config --global user.email '11232728+cloudpossebot@users.noreply.github.com'
  git add -A -- ':!'"${IGNORE_PATH}"'' ':!github-action-terraform-ci'
  git commit -m "Auto Format"
else
  echo "No changes detected"
fi
