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

git diff > /dev/null
echo $?
git diff --staged > /dev/null
echo $?
git diff --cached > /dev/null
echo $?
git diff --staged --exit-code > /dev/null
echo $?
git diff --cached --exit-code > /dev/null
echo $?

if git diff --staged; then
  git commit -m "Adding .github files"
fi
