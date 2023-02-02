#!/usr/bin/env bats
setup() {
    load 'test_helper/ext-setup'
    _ext_setup
    load "../${TEST_UNDER_EXAMINATION}"
    DOCUMENTROOT="${TEST_PROJECT_DIR}/public_html"
    OUT_HTML="${DOCUMENTROOT}/index.html"
    DOCUMENTS_DIR="${TEST_PROJECT_DIR}/documents"
    STORE_TEMPLATES_HERE="${TEST_PROJECT_DIR}/.pandoc/template" #???
    TMPL_TO_CONVERT_MD_INTO_HTML="test_default.html"
    IN_MARKDOWN="${DOCUMENTS_DIR}/index.md"
    DATA_DIR="${TEST_PROJECT_DIR}"
    WITH_METADATA="${DOCUMENTS_DIR}/metadata.yaml"
    A_CSS_FILE="${DOCUMENTS_DIR}/pandoc.css"
    PARAM_STANDALONE_HTML_PAGE="--standalone"
    PARAM_PARTIAL_HTML_PAGE=""
    LANG='language_COUNTRY'
    TITLE='Hello World'
    PAGE_TITLE='What a beautifuly DAY'
    if [[ ! -e "${FIRST_RUN_OF_TEST_UNDER_EXAMINATION}" ]]; then
        mkdir -pv ${STORE_TEMPLATES_HERE}  ${DOCUMENTS_DIR} ${TEST_PROJECT_DIR} ${DOCUMENTROOT}
        touch ${IN_MARKDOWN} ${WITH_METADATA} 
        #${CSS}
        printf "%s\n%s\n%s\n" "pagetitle: '${PAGE_TITLE}'" "title: '${TITLE}'" "lang: '${LANG}'" > "${WITH_METADATA}"
        pandoc --print-default-template=html5 > ${STORE_TEMPLATES_HERE}/${TMPL_TO_CONVERT_MD_INTO_HTML}       
        touch "${FIRST_RUN_OF_TEST_UNDER_EXAMINATION}"
    fi
}

@test "maping named parameter to pandoc cli" {
   
    # Inject metadata and css into an HTML document,
    # that was buid via a specific template from a markdown document
    # Calling TEST_UNDER_EXAMINATION.bash instead of function to
    # prevent the function from acessing global variables from this test
    ${TEST_UNDER_EXAMINATION}.bash \
            "CSS=${A_CSS_FILE}" \
            "OUTPUT_FILE=${OUT_HTML}" \
            "INPUT_FILE=${IN_MARKDOWN}" \
            "DATA_DIR=${TEST_PROJECT_DIR}" \
            "METADATA_FILE=${WITH_METADATA}" \
            "STANDALONE_OR_PARTIAL=${PARAM_STANDALONE_HTML_PAGE}" \
            "TEMPLATE=${STORE_TEMPLATES_HERE}/${TMPL_TO_CONVERT_MD_INTO_HTML}"

    [ "${OUT_HTML}" == "-" ] && skip 'output was not send to a file'
    run cat "${OUT_HTML}"
    refute_output --regexp '(\[INFO\]|\[WARNING\])'
    assert_output --partial "lang=\"${LANG}\" xml:lang=\"${LANG}\""    
    assert_output --partial "<title>${PAGE_TITLE}</title>"
    assert_output --partial "\"title\">${TITLE}"
    assert_output --partial "rel=\"stylesheet\" href=\"${A_CSS_FILE}\""

} 

@test "fail without positional paramerter" {
    run ${TEST_UNDER_EXAMINATION}
    assert_failure
}