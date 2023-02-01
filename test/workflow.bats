#!/usr/bin/env bats
setup() {
    load 'test_helper/ext-setup'
    _ext_setup

    load "../${TEST_UNDER_EXAMINATION}"
    load "../property_check"
    if [[ ! -e "${FIRST_RUN_OF_TEST_UNDER_EXAMINATION}" ]]; then
        mkdir -pv "${TEST_PROJECT_DIR}"
        touch "${FIRST_RUN_OF_TEST_UNDER_EXAMINATION}"
    fi
}

@test 'properties check' {
    run property_check 'USER' 'HOME' 'LANG' 'SHELL'
    assert_output --partial 'ff7525880eb70593a8cb86c6ec348b01cba88f87a71cbf845497995d34190a2f'
}



@test 'assert_output() partial matching' {
    
    PROJECT_DIR="{TEST_PROJECT_DIR}"
    FOO='bar'
    local -ar ENVIRONMENT+=( \
                "PROJECT_DIR=${PROJECT_DIR}" \
                "FOO=${FOO}")
    printf -v environment "%s\n%s\n" "${ENVIRONMENT[0]}" "${ENVIRONMENT[1]}"
    CHECKSUM="$(sha256sum <<< "${environment}")"
    run "${TEST_UNDER_EXAMINATION}" "${ENVIRONMENT[@]}"
    #assert_output --partial "${ENVIRONMENT[0]}"
    #assert_output --partial "${ENVIRONMENT[1]}"
    assert_output --partial "${CHECKSUM}"


}

@test "fail without positional paramerter" {
    run ${TEST_UNDER_EXAMINATION}
    assert_failure
}