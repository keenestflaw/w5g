#!/usr/bin/env bats
setup() {
    load 'test_helper/ext-setup'
    _ext_setup
    load "../${TEST_UNDER_EXAMINATION}"
    DOCUMENTROOT="${TEST_PROJECT_DIR}/public_html"
    OUT_HTML="${DOCUMENTROOT}/index.html"
    #OUT_HTML="-"
    DOCUMENTS_DIR="${TEST_PROJECT_DIR}/documents"
    DATA_DIR="${TEST_PROJECT_DIR}/.pandoc/template"
    IN_MARKDOWN="${DOCUMENTS_DIR}/index.md"
    WITH_METADATA="${DOCUMENTS_DIR}/metadata.yaml"
    PARAM_STANDALONE_HTML_PAGE="--standalone"
    PARAM_PARTIAL_HTML_PAGE=""
    LANG='language_COUNTRY'
    TITLE='Hello World'
    PAGE_TITLE='What a beautifuly DAY'
    if [[ ! -e "${FIRST_RUN_OF_TEST_UNDER_EXAMINATION}" ]]; then
        mkdir -pv ${DATA_DIR} ${DOCUMENTS_DIR} ${TEST_PROJECT_DIR} ${DOCUMENTROOT}
        touch ${IN_MARKDOWN} ${WITH_METADATA}
        printf "%s\n%s\n%s\n" "pagetitle: '${PAGE_TITLE}'" "title: '${TITLE}'" "lang: '${LANG}'" > "${WITH_METADATA}"
        pandoc --print-default-template=html5 > ${DATA_DIR}/default.html        
        touch "${FIRST_RUN_OF_TEST_UNDER_EXAMINATION}"
        ${TEST_UNDER_EXAMINATION} "OUTPUT_FILE=${OUT_HTML}" "INPUT_FILE=${IN_MARKDOWN}" "METADATA_FILE=${WITH_METADATA}" "STANDALONE_OR_PARTIAL=${PARAM_STANDALONE_HTML_PAGE}"
    fi
}

@test "inject metadata into an HTML document, that was buid from an markdown document" {
    [ "${OUT_HTML}" == "-" ] && skip 'output was not send to a file'
    run cat "${OUT_HTML}"
    refute_output --regexp '(\[INFO\]|\[WARNING\])'
    assert_output --partial "lang=\"${LANG}\" xml:lang=\"${LANG}\""    
    assert_output --partial "<title>${PAGE_TITLE}</title>"
    assert_output --partial "\"title\">${TITLE}"

} 


@test "fail without positional paramerter" {
    run ${TEST_UNDER_EXAMINATION}
    assert_failure
}
