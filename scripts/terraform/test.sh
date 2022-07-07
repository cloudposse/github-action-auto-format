#!/bin/bash
# test.sh

# source functions from format.sh
# passing --source-only option to avoid executing any of the code in format.sh during sourcing
. $(cwd)/../format.sh --source-only

TEST_FOLDER="./scripts/terraform/test/"

mv ${TEST_FOLDER}*.tf .

# sourced from format.sh
terraform_format

mv ./*.tf ${TEST_FOLDER}

# sourced from format.sh
commit
