#!/bin/bash
# test.sh

# if this is the cloudposse/github-action-auto-format repository, don't copy the version of auto-format.yml from cloudposse/.github during testing
rm ./.github/.github/workflows/auto-format.yml

$(cwd)/../format.sh
