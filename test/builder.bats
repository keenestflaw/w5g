#!/usr/bin/env bats
setup() {
    load 'test_helper/ext-setup'
    _ext_setup

    load "../${TEST_UNDER_EXAMINATION}"
    if [[ ! -e "${FIRST_RUN_OF_TEST_UNDER_EXAMINATION}" ]]; then
        DOCUMENTS_DIR="${TEST_PROJECT_DIR}/documents"
        DATA_DIR="${DOCUMENTS_DIR}/.pandoc/template"
        mkdir -pv ${DATA_DIR} ${DOCUMENTS_DIR} ${TEST_PROJECT_DIR}
        pandoc --print-default-template=html5 > ${DATA_DIR}/default.html
        touch "${DOCUMENTS_DIR}/index.md"
        touch "${DOCUMENTS_DIR}/metadata.yaml"
        touch "${DOCUMENTS_DIR}/default.yaml"
        touch "${DOCUMENTS_DIR}/index.yaml"
        touch "${FIRST_RUN_OF_TEST_UNDER_EXAMINATION}"
    fi
}

@test "foo" {
    run ${TEST_UNDER_EXAMINATION} ""
    assert_success    
    
}

@test "fail without positional paramerter" {
    run ${TEST_UNDER_EXAMINATION}
    assert_failure
}