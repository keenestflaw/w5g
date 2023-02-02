
#builder_cli_args() {
#    set -o errexit
#    set -o nounset
#    source <(printf "%s\n" "${@}");
#cat << BUILDER_ARGUMENTS
#--from=markdown ${INPUT_FILE} \
#--to=html --output=${OUTPUT_FILE} \
#--metadata-file=${METADATA_FILE} \
#${STANDALONE_OR_PARTIAL} \
#--verbose
#BUILDER_ARGUMENTS
#}

builder() {
    set -o errexit
    set -o nounset
    source <(printf "%s\n" "${@}")
    pandoc \
        --from=markdown "${INPUT_FILE}" \
        --to=html --output="${OUTPUT_FILE}" \
        --metadata-file="${METADATA_FILE}" \
        --data-dir="${DATA_DIR}" --template="${TEMPLATE}" \
        --css="${CSS}" \
        ${STANDALONE_OR_PARTIAL} \
        --verbose
}


(return 0 2>/dev/null) || "$(basename "${0%.*}")" "${@}"