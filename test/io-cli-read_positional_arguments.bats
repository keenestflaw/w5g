#!/usr/bin/env bats
setup() {
    load 'test_helper/ext-setup'
    _ext_setup
    load "../${TEST_UNDER_EXAMINATION}"
    if [[ ! -e "${FIRST_RUN_OF_TEST_UNDER_EXAMINATION}" ]]; then
        touch ${FIRST_RUN_OF_TEST_UNDER_EXAMINATION}
    fi
}

@test "test something." {
    run ${TEST_UNDER_EXAMINATION} 
    assert_failure
}