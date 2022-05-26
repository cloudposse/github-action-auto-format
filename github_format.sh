#!/bin/bash

set -x

echo "Copying workflows from cloudposse/.github repo"

mkdir gha_tmp_dir
cd gha_tmp_dir
git clone https://github.com/cloudposse/.github

git config --global --add safe.directory /github/workspace

## Deal with each workflow in cloudposse/.github/.github/workflows separately:

# auto-context.yml
# only Terraform repos should get this workflow
if [ $(git ls-files | grep .tf$ | wc -l) -gt 0 ]; then
  cp ./.github/.github/workflows/auto-context.yml ../.github/workflows/
fi

## auto-format.yml
# if this is the cloudposse/github-action-auto-format repository, don't copy the version of auto-format.yml from cloudposse/.github during testing
if [[ "$(git config --get remote.origin.url)" =~ cloudposse\/github-action-auto-format ]]; then
  rm ./.github/.github/workflows/auto-format.yml
else
  echo "$(git config --get remote.origin.url)"
fi
# all repos should get this workflow
cp ./.github/.github/workflows/auto-format.yml ../.github/workflows/

# auto-release.yml
# all repos should get this workflow
cp ./.github/.github/workflows/auto-release.yml ../.github/workflows/

# ci-terraform.yml
# only repos with Terraform files shuld get this workflow
if [ $(git ls-files | grep .tf$ | wc -l) -gt 0 ]; then
  cp ./.github/.github/workflows/auto-context.yml ../.github/workflows/
fi

## validate-codeowners.yml
# all repos should get this workflow
cp ./.github/.github/workflows/validate-codeowners.yml ../.github/workflows/



cd ..
rm -rf ./gha_tmp_dir

git config --local user.name "${BOT_NAME}"
git config --local user.email "${BOT_EMAIL}"
git add ./.github/workflows/*
# Don't try committing without any files staged. That returns a non-zero exit code.
if ! git diff --staged --exit-code; then
  git commit -m "Adding .github files"
fi
