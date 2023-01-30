#!/usr/bin/env bash

 tap_print_var_value() {
    printf "%s\n" "# \${${1}}='${!1}'" >&3
 }
    
_ext_setup() {
    LC_ALL=POSIX
    load 'test_helper/bats-support/load'
    load 'test_helper/bats-assert/load'
    load 'test_helper/bats-file/load'
    # get the containing directory of this file
    # use $BATS_TEST_FILENAME instead of ${BASH_SOURCE[0]} or $0,
    # as those will point to the bats executable's location or the preprocessed file respectively
    PROJECT_ROOT="$( cd "$( dirname "${BATS_TEST_FILENAME}" )/.." >/dev/null 2>&1 && pwd )"
    # make executables in src/ visible to PATH
    #PATH="$PROJECT_ROOT/src:$PATH"
    PATH="${PROJECT_ROOT}:$PATH"
    TEST_BUILD_DIR='/tmp/bats'
    TEST_UNDER_EXAMINATION="$(basename ${BATS_TEST_FILENAME%.*})"
    TEST_CONCERN_DIR="${TEST_BUILD_DIR}/${TEST_UNDER_EXAMINATION}"
    TEST_PROJECT_DIR="${TEST_CONCERN_DIR}/project_folder"
    FIRST_RUN_OF_TEST_UNDER_EXAMINATION="${TEST_BUILD_DIR}/first_run_${TEST_UNDER_EXAMINATION}"
}
