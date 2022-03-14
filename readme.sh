#!/bin/bash

make BUILD_HARNESS_PATH=/build-harness PACKAGES_PREFER_HOST=true -f /build-harness/templates/Makefile.build-harness pr/readme/host

set -x

output=$(git diff --name-only)
if [ -n "$output" ]; then
  echo "Changes detected. Pushing to the PR branch"
  git config --global user.name 'cloudpossebot'
  git config --global user.email '11232728+cloudpossebot@users.noreply.github.com'
  git add -A
  git commit -m "Auto Format"
  # Prevent looping by not pushing changes in response to changes from cloudpossebot
  [[ $SENDER ==  "cloudpossebot" ]] || git push
  # Set status to fail, because the push should trigger another status check,
  # and we use success to indicate the checks are finished.
  printf "::set-output name=%s::%s\n" "changed" "true"
  exit 1
else
  printf "::set-output name=%s::%s\n" "changed" "false"
  echo "No changes detected"
fi
