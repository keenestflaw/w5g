#!/usr/bin/env bats
setup() {
    load 'test_helper/ext-setup'
    _ext_setup
    load "../${TEST_UNDER_EXAMINATION}"
    if [[ ! -e "${FIRST_RUN_OF_TEST_UNDER_EXAMINATION}" ]]; then
        mkdir -pv "${TEST_PROJECT_DIR}"
        touch "${FIRST_RUN_OF_TEST_UNDER_EXAMINATION}"
    fi
}

@test "test something." {

    #local -ra _test_evironment_variable_names_=('USER' 'HOME' 'LANG')
    local -ra _test_evironment_variable_names_=('USER' 'HOME' 'LANG' 'SHELL')
    #local -ra _test_evironment_variable_value_=("${USER}" "${HOME}" "${LANG}" "/bin/bash")
    local -ra _test_evironment_variable_value_=("${USER}" "${HOME}" "${LANG}" "${SHELL}")


 
    #local -A test_properties
    #test_properties+=([${key}]+="${!key}")
    local  -a test_configuration_items=()
    for key in "${!_test_evironment_variable_names_[@]}"; do
        test_configuration_items+=("${_test_evironment_variable_names_[$key]}=${_test_evironment_variable_value_[$key]}")
    done
    local test_environment=''
    printf -v test_environment "%s" "${test_configuration_items[@]}" 
    printf -v test_checksum "%s" "$(sha256sum <<< "${test_environment}")"


    for test_item in ${test_configuration_items[@]}; do
        tap_print_var_value test_item
    done
    tap_print_var_value test_checksum

    run ${TEST_UNDER_EXAMINATION} "${_test_evironment_variable_names_[@]}"
    assert_output --partial "${test_checksum}"
}
