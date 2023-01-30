#!/usr/bin/env bats
setup() {
    load 'test_helper/ext-setup'
    _ext_setup
}

@test 'dump the remains of earlier test fom the playground' {
    tap_print_var_value TEST_BUILD_DIR
    rm -rfv ${TEST_BUILD_DIR} | sed s/^/\#\ / >&3 
    assert [ ! -d ${TEST_BUILD_DIR} ] 
}

@test 'create new playground for the test' {
    tap_print_var_value TEST_BUILD_DIR
    mkdir -pv ${TEST_BUILD_DIR} | sed s/^/\#\ / >&3 
    assert [ -d ${TEST_BUILD_DIR} ] 
}
