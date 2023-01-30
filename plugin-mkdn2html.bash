#!/usr/bin/env bash
plugin-mkdn2html() {
    set -o nounset
    source io-cli-read_positional_arguments.bash
    io-cli-read_positional_arguments "${@}" 
    local -r _html_file_="${arguments[0]}"
    local -r _markdown_file_="${arguments[1]}"
    local -r _metadata_file_="${arguments[2]}"
    source ./debug_print_name_value.bash
    debug_print_name_value _html_file_
    debug_print_name_value _markdown_file_
    debug_print_name_value _metadata_file_

    io-html2mkdn-pandoc.bash <(port-mkdn2html-positional2named_parameter.bash ${_html_file_} ${_markdown_file_} ${_metadata_file_})
}
(return 0 2>/dev/null) || "$(basename "${0%.*}")" "${@}"