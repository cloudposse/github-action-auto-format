#!/bin/bash
# self-test.sh

TEST_FOLDER="./scripts/context/test/"

mv ${TEST_FOLDER}context.tf .
echo "Moved context.tf to top-level directory."

$(cwd)/../format.sh

mv context.tf ${TEST_FOLDER}
echo "Moved context.tf back to ./test/ directory."
