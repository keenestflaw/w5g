#!/usr/bin/env bats
setup() {
    load 'test_helper/ext-setup'
    _ext_setup
}

@test 'list \${TEST_BUILD_DIR}' {
    tap_print_var_value TEST_BUILD_DIR
    printf "%s" "$(tree --timefmt '%H:%m:%S' --dirsfirst ${TEST_BUILD_DIR})" |sed s/^/\#\ / >&3&
}

