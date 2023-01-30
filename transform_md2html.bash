#!/usr/bin/env bash
transform_md2html() {
source io-cli-read_positional_arguments.bash
io-cli-read_positional_arguments "${@}" 
    io-html2mkdn-pandoc.bash <(port-mkdn2html-positional2named_parameter.bash ${arguments[0]} ${arguments[1]} ${arguments[2]})
}
(return 0 2>/dev/null) || "$(basename "${0%.*}")" "${@}"