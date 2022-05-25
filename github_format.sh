#!/bin/bash

set -x

echo "Copying workflows from cloudposse/.github repo"

mkdir gha_tmp_dir
cd gha_tmp_dir
git clone https://github.com/cloudposse/.github
##### DEBUG
rm ./.github/.github/workflows/auto-format.yml
##### /DEBUG
cp ./.github/.github/workflows/*.yml ../.github/workflows/
cd ..
rm -rf ./gha_tmp_dir

pwd
ls -lhat
ls -lhat ..
whoami
git --version
git config --global --add safe.directory /github/workspace
git status
git config --local user.name "${BOT_NAME}"
git config --local user.email "11232728+${BOT_NAME}@users.noreply.github.com"
git add ./.github/workflows/*
# Don't try committing without any files staged. That returns a non-zero exit code.
if ! git diff --staged --exit-code; then
  git commit -m "Adding .github files"
fi
