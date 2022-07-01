#!/bin/bash
# format.sh

set -x

echo "Copying workflows from cloudposse/.github repo"

# Copy cloudposse/.github repo in order to clone workflows
mkdir gha_tmp_dir
cd gha_tmp_dir || exit 1
git clone https://github.com/cloudposse/.github

## Deal with each workflow in cloudposse/.github/.github/workflows separately:

# auto-format.yml
# all repos should get this workflow
cp ./.github/.github/workflows/auto-format.yml ../.github/workflows/

# auto-release.yml
# all repos should get this workflow
cp ./.github/.github/workflows/auto-release.yml ../.github/workflows/

# ci-terraform.yml
# only repos with Terraform files shuld get this workflow
if [ "$(git ls-files | grep .tf$ | wc -l)" -gt 0 ]; then
  cp ./.github/.github/workflows/auto-context.yml ../.github/workflows/
fi

## validate-codeowners.yml
# all repos should get this workflow
cp ./.github/.github/workflows/validate-codeowners.yml ../.github/workflows/

# Remove local copy of cloudposse/.github repo
cd ..
rm -rf ./gha_tmp_dir

# Don't try committing without any files staged. That returns a non-zero exit code.
git add ./.github/workflows/*
if ! git diff --staged --exit-code; then
  git commit -m "Adding .github files"
fi
