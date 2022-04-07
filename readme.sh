#!/bin/bash

make BUILD_HARNESS_PATH=/build-harness PACKAGES_PREFER_HOST=true -f /build-harness/templates/Makefile.build-harness pr/readme/host

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

# The `readme` build-harness target leaves some files lying around after it finishes. Since we might be running other targets after this, in separate GitHub Action steps, we don't want to leave these files lying there, waiting to return some permission error or something.
rm -r .build-harness/
rm -r docs/
