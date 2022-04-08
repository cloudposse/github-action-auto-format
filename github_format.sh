#!/bin/bash

set -x

echo "Copying workflows from cloudposse/.github repo"
git config --local user.name "${BOT_NAME}"
git config --local user.email "11232728+${BOT_NAME}@users.noreply.github.com"

mkdir gha_tmp_dir
cd gha_tmp_dir
git clone https://github.com/cloudposse/.github
cp ./.github/workflow-templates/*.yml ../.github/workflows/
cd ..
rm -rf ./gha_tmp_dir

git add -A -- ':!'"${IGNORE_PATH}"''
# Don't try committing without any files staged. That returns a non-zero exit code.
if ! git diff --staged --exit-code; then
  git commit -m "Adding .github files"
fi
