io-html2mkdn-pandoc() {
source debug_print_name_value.bash
source io-cli-read_positional_arguments.bash
io-cli-read_positional_arguments "${@}" 
source  <(echo "${arguments[@]}")
pandoc "${INPUT_FILE}" --output="${OUTPUT_FILE}" --metadata-file=${METADATA_FILE} -s --verbose --trace
}
(return 0 2>/dev/null) || "$(basename "${0%.*}")" "${@}"
