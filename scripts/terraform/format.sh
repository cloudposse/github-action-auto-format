#!/bin/bash
# format.sh

# I had to factor everything into functions and add the if statement at the end to accommodate
# the source (.) function in ./test/self-test.sh

terraform_format () {
  make BUILD_HARNESS_PATH=/build-harness PACKAGES_PREFER_HOST=true -f /build-harness/templates/Makefile.build-harness terraform/fmt
}

commit () {
  set -x
  
  output=$(git diff --name-only)
  if [ -n "$output" ]; then
    echo "Changes detected. Pushing to the PR branch"
    git add -A -- ':!'"${IGNORE_PATH}"''
    git commit -m "Auto formatting Terraform files"
  else
    echo "No changes detected"
  fi
}


if [ "${1}" != "--source-only" ]; then
    terraform_format
    commit
fi
