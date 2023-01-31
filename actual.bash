
actual() {
    set -o nounset
    [[ -z ${1} ]]
}

get_first_missing_file_or_older() {
    set -o nounset
    local -r first_file="${1}"
    local -r last_file="${2}"

    if [[ -e "${first_file}" ]]; then
        if [[ ! -e "${last_file}" ]]; then
            printf "%s\n" "${last_file}" # does not exist
        elif [[ "${last_file}" -ot "${first_file}" ]]; then
            printf "%s\n" "${last_file}" # exists and is older
        else
            printf "%s\n" "${first_file}" # exists and is older
        fi 
    else
        printf "%s\n" "${first_file}" # does not exist
    fi
}

(return 0 2>/dev/null) || "$(basename "${0%.*}")" "${@}"