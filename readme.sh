#!/bin/bash

make BUILD_HARNESS_PATH=/build-harness PACKAGES_PREFER_HOST=true -f /build-harness/templates/Makefile.build-harness pr/readme/host

set -x

# The `readme` build-harness target leaves some files lying around after it finishes. Since we might be running other targets after this, in separate GitHub Action steps, we don't want to leave these files lying there, waiting to return some permission error or something. That's why they get deleted, whether there were changes to `README.md` or not.

output=$(git diff --name-only)
if [ -n "$output" ]; then
  echo "Changes detected. Pushing to the PR branch"
  git config --global user.name "${BOT_NAME}"
  git config --global user.email "11232728+${BOT_NAME}@users.noreply.github.com"
  rm .build-harness
  rm -r docs/
  git add -A -- ':!'"${IGNORE_PATH}"''
  git commit -m "Updating README.md"
else
  echo "No changes detected"
  rm .build-harness
  rm -r docs/
fi
