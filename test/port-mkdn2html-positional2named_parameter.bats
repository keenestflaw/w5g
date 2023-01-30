#!/usr/bin/env bats
setup() {
    load 'test_helper/ext-setup'
    _ext_setup
    load "../${TEST_UNDER_EXAMINATION}"
    if [[ ! -e "${FIRST_RUN_OF_TEST_UNDER_EXAMINATION}" ]]; then
        touch ${FIRST_RUN_OF_TEST_UNDER_EXAMINATION}
    fi
}

@test 'Validate properties of transformation data for document pre processor' {
    source <(port-mkdn2html-positional2named_parameter 'out.html' 'in.md' 'metadata.yaml')
    assert [ ! -z "${OUTPUT_FILE}" ]
    tap_print_var_value OUTPUT_FILE
    assert [  ! -z "${INPUT_FILE}" ]
    tap_print_var_value INPUT_FILE
    assert [ ! -z "${METADATA_FILE}" ]
    tap_print_var_value METADATA_FILE
}

