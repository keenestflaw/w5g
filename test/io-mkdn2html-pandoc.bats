#!/usr/bin/env bats

setup() {
    load 'test_helper/ext-setup'
    _ext_setup
    load "../${TEST_UNDER_EXAMINATION}"
    load '../port-mkdn2html-positional2named_parameter'
    DOCUMENTS_DIR="${TEST_PROJECT_DIR}/documents"
    DATA_DIR="${DOCUMENTS_DIR}/.pandoc/template"
    if [[ ! -e "${FIRST_RUN_OF_TEST_UNDER_EXAMINATION}" ]]; then
        mkdir -pv ${DATA_DIR} ${DOCUMENTS_DIR} ${TEST_PROJECT_DIR}
        pandoc --print-default-template=html5 > ${DATA_DIR}/default.html
        touch "${DOCUMENTS_DIR}/index.md"
        touch "${DOCUMENTS_DIR}/metadata.yaml"
        touch "${DOCUMENTS_DIR}/default.yaml"
        touch "${DOCUMENTS_DIR}/index.yaml"
        touch "${FIRST_RUN_OF_TEST_UNDER_EXAMINATION}"
    fi
}

@test 'Produced a HTML file from a MARKDOWN document at the document facility' {
    io-mkdn2html-pandoc \
        <(port-mkdn2html-positional2named_parameter \
        "${DOCUMENTS_DIR}/index.html" "${DOCUMENTS_DIR}/index.md" "${DOCUMENTS_DIR}/metadata.yaml" "${DATA_DIR}")
    assert [ -e "${DOCUMENTS_DIR}/index.html" ]
}