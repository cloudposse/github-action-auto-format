#!/bin/bash

set -x

echo "Copying workflows from cloudposse/.github repo"
git config --local user.name 'cloudpossebot'
git config --local user.email '11232728+cloudpossebot@users.noreply.github.com'

mkdir gha_tmp_dir
cd gha_tmp_dir
git clone https://github.com/cloudposse/.github
cp ./.github/workflow-templates/*.yml ../.github/workflows/
cd ..
rm -rf ./gha_tmp_dir

git add -A -- ':!'"${IGNORE_PATH}"''
# Prevent looping by not pushing changes in response to changes from cloudpossebot
if [[ "$EVENT_TYPE" != "schedule" && "$EVENT_TYPE" != "workflow_dispatch" ]]; then
  git commit -m "Adding .github files"
  [[ $SENDER ==  "cloudpossebot" ]] || git push
fi
