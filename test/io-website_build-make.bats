#!/usr/bin/env bats

setup() {
    load 'test_helper/ext-setup'
    _ext_setup
    TARGET='build'
    PARAM_TARGET="${TARGET}"
    BUILD_DIRECTORY="${TEST_PROJECT_DIR}"
    PARAM_TARGET_LOCK="${BUILD_DIRECTORY}/${TARGET}"
    PARAM_BUILD_DIRECTORY="--directory=${BUILD_DIRECTORY}"
    DOCUMENT_DIR="${BUILD_DIRECTORY}/documents"
    MKDN_FILE="${DOCUMENT_DIR}/index.md"
    PARAM_MKDN_FILE="${MKDN_FILE}"
    PARAM_DOCUMENT_DIR="DOCUMENT_DIR=${DOCUMENT_DIR}" 
    METADATA_FILE="${DOCUMENT_DIR}/metadata.yaml"
    PARAM_METADATA_FILE="${METADATA_FILE}"
    DOCUMENTROOT="${BUILD_DIRECTORY}/public_html"
    PARAM_HTML_FILE="${DOCUMENTROOT}/index.html"
    PARAM_DOCUMENTROOT="DOCUMENTROOT=${DOCUMENTROOT}"
    load "../${TEST_UNDER_EXAMINATION}"
    if [[ ! -e "${FIRST_RUN_OF_TEST_UNDER_EXAMINATION}" ]]; then
        mkdir -pv "${DOCUMENT_DIR}" "${DOCUMENTROOT}" "${BUILD_DIRECTORY}"
        cp -v makefile "${BUILD_DIRECTORY}"
        touch ${MKDN_FILE}
        touch ${METADATA_FILE}
        printf "%s\n%s\n" 'title: TITEL' 'lang: de_DE' > "${METADATA_FILE}"
        ${TEST_UNDER_EXAMINATION} "${PARAM_TARGET}" "${PARAM_BUILD_DIRECTORY}" "${PARAM_DOCUMENT_DIR}" "${PARAM_DOCUMENTROOT}"
        touch "${FIRST_RUN_OF_TEST_UNDER_EXAMINATION}"
    fi
}

@test "buid at least an one HTML file if" {
    assert [ $(find "${DOCUMENTROOT}" -type f -name "*.html"|wc -l) -gt '0' ] 
}

@test "first build done" {
    assert [ -e ${PARAM_TARGET_LOCK} ]
}

@test "build fails when all positional parameter are missing" {
    run "${TEST_UNDER_EXAMINATION}" 
    assert_failure 
}

@test "build fails when a positional parameter is missing" {
    run "${TEST_UNDER_EXAMINATION}" "$(mktemp --dry-run)"
    assert_failure 
}
