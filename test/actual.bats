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


@test 'get older or first of ' {
    local -r old_file_exist="${TEST_PROJECT_DIR}/old_exist.file"
    local -r new_file_exist="${TEST_PROJECT_DIR}/new_exist.file"
    local -r first_file_does_not_exist="${TEST_PROJECT_DIR}/first_does_not_exist.file"
    local -r last_file_does_not_exist="${TEST_PROJECT_DIR}/last_does_not_exist.file"

    touch -t '200001010000.00' "${old_file_exist}" 
    touch -t '200001010000.01' "${new_file_exist}" 

    run get_first_missing_file_or_older "${first_file_does_not_exist}" "${old_file_exist}"
    assert_output "${first_file_does_not_exist}"
    run get_first_missing_file_or_older "${first_file_does_not_exist}" "${old_file_exist}"
    assert_output "${first_file_does_not_exist}"
    run get_first_missing_file_or_older "${first_file_does_not_exist}" "${last_file_does_not_exist}"
    assert_output "${first_file_does_not_exist}"
    run get_first_missing_file_or_older "${old_file_exist}" "${last_file_does_not_exist}"
    assert_output "${last_file_does_not_exist}"
    run get_first_missing_file_or_older "${new_file_exist}" "${last_file_does_not_exist}"
    assert_output "${last_file_does_not_exist}"
}


@test 'get older or the first of both files existing files' {
    local -r old_file="${TEST_PROJECT_DIR}/old.file"
    local -r new_file="${TEST_PROJECT_DIR}/new.file"
    local -r same_date_as_new_file="${TEST_PROJECT_DIR}/same_date_as_new.file"
    local -r same_date_as_old_file="${TEST_PROJECT_DIR}/same_date_as_old.file"
    touch -t '200001010000.00' "${old_file}" "${same_date_as_old_file}"
    touch -t '200001010000.01' "${new_file}" "${same_date_as_new_file}"
    run get_first_missing_file_or_older "${new_file}" "${old_file}"
    assert_output "${old_file}"
    run get_first_missing_file_or_older "${old_file}" "${new_file}"
    assert_output "${old_file}"
    run get_first_missing_file_or_older "${old_file}" "${old_file}"
    assert_output "${old_file}"
    run get_first_missing_file_or_older "${new_file}" "${new_file}"
    assert_output "${new_file}"
    run get_first_missing_file_or_older "${old_file}" "${same_date_as_old_file}"
    assert_output "${old_file}"
    run get_first_missing_file_or_older "${new_file}" "${same_date_as_new_file}"
    assert_output "${new_file}"
    run get_first_missing_file_or_older "${same_date_as_old}" "${old_file}"
    assert_output "${same_date_as_old}"
    run get_first_missing_file_or_older "${same_date_as_new_file}" "${new_file}"
    assert_output "${same_date_as_new_file}"
    run get_first_missing_file_or_older "${same_date_as_old}" "${same_date_as_old_file}"
    assert_output "${same_date_as_old}"
    run get_first_missing_file_or_older "${same_date_as_new_file}" "${same_date_as_new_file}"
    assert_output "${same_date_as_new_file}"

}



@test "fail without positional paramerter" {
    run ${TEST_UNDER_EXAMINATION}
    assert_failure
}