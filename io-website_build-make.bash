
io-website_build-make() {
    set -o nounset
    source ./debug_print_name_value.bash
    local -r _param_target_="${1}"
    local -r _param_directory_="${2}"
    local -r _param_document_dir_="${3}"
    local -r _param_documentroot_="${4}"
    debug_print_name_value _param_target_
    debug_print_name_value _param_directory_
    debug_print_name_value _param_document_dir_
    debug_print_name_value _param_documentroot_
    make "${_param_target_}" "${_param_directory_}" "${_param_document_dir_}" "${_param_documentroot_}" --trace
}
(return 0 2>/dev/null) || "$(basename "${0%.*}")" "${@}"