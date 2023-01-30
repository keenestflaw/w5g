local -a arguments=()
read_positional_parameter() {
    while [[ "${#}" != '0' ]]; do arguments+=("${1}"); shift; done 
}
read_parameter_from_pipe() {
    local -r ORIG_OPTS="${-}"
    set +o errexit
    local -r ORIG_IFS="${IFS}"
    IFS=$';\n' # don't stop on 'semicolons' and 'newlines'
    read -d '' -a arguments # -d '' works like a charm, but with exit code (1)?!
    IFS="$ORIG_IFS"
    set "${ORIG_OPTS}"
}

io-cli-read_positional_arguments() {
    if [[ "${#}" == '0' ]]; then # read from stdin
        exit 1
        #read_parameter_from_pipe
    elif [[ -p "${1}" ]]; then  # read from named pipe
        exec <${1}
        read_parameter_from_pipe
    elif [[ "${@}" != '-' ]]; then # read from command line 
        read_positional_parameter "${@}"
    fi
}
(return 0 2>/dev/null) || "$(basename "${0%.*}")" "${@}"