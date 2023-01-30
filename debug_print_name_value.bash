#!/usr/bin/env bash
debug_print_name_value() {
    printf "%s\n" "\${${1}}='${!1}'" >&2
}
