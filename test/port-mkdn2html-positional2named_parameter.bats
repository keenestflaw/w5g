#!/usr/bin/env bats
setup() {
    load 'test_helper/ext-setup'
    _ext_setup
    load "../${TEST_UNDER_EXAMINATION}"
    DOCUMENTS_DIR="${TEST_PROJECT_DIR}/documents"
    DATA_DIR="${DOCUMENTS_DIR}/.pandoc/template"
    if [[ ! -e "${FIRST_RUN_OF_TEST_UNDER_EXAMINATION}" ]]; then
        mkdir -pv ${DATA_DIR} ${DOCUMENTS_DIR} ${TEST_PROJECT_DIR}
        pandoc --print-default-template=html5 > ${DATA_DIR}/default.html
        touch ${FIRST_RUN_OF_TEST_UNDER_EXAMINATION}
    fi
}

@test 'Validate properties of transformation data for document pre processor' {
    source <(port-mkdn2html-positional2named_parameter 'out.html' 'in.md' 'metadata.yaml' "${DATA_DIR}")
    assert [ ! -z "${OUTPUT_FILE}" ]
    tap_print_var_value OUTPUT_FILE
    assert [  ! -z "${INPUT_FILE}" ]
    tap_print_var_value INPUT_FILE
    assert [ ! -z "${METADATA_FILE}" ]
    tap_print_var_value METADATA_FILE
    assert [ ! -z "${DATA_DIR}" ]
    tap_print_var_value DATA_DIR
}

