
io-website_build-make() {
    set -o nounset
    source debug_print_name_value.bash
    local -r _param_target_="${1}"
    local -r _param_directory_="${2}"
    local -r _param_document_dir_="${3}"
    local -r _param_documentroot_="${4}"
    local -r _param_data_dir_="${5}"
    debug_print_name_value _param_target_
    debug_print_name_value _param_directory_
    debug_print_name_value _param_document_dir_
    debug_print_name_value _param_documentroot_
    debug_print_name_value _param_data_dir_
    printf "%s %s %s %s %s %s %s \n" \
            "make" \
            "${_param_target_}" \
            "${_param_directory_}" \
            "${_param_document_dir_}" \
            "${_param_documentroot_}" \
            "${_param_data_dir_}" \
            "--trace" > "$(mktemp --suffix=_make.bash)"
    make "${_param_target_}" "${_param_directory_}" "${_param_document_dir_}" "${_param_documentroot_}" "${_param_data_dir_}" --trace
}
(return 0 2>/dev/null) || "$(basename "${0%.*}")" "${@}"