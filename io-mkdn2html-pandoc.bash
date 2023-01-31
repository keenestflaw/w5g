io-mkdn2html-pandoc() {
source io-cli-read_positional_arguments.bash
io-cli-read_positional_arguments "${@}"
source  <(echo "${arguments[@]}")
pandoc \
    --from=markdown "${INPUT_FILE}" \
    --to=html --output="${OUTPUT_FILE}" \
    --metadata-file=${METADATA_FILE} \
    --data-dir=${DATA_DIR} \
    --standalone  --verbose --trace 
#    --template=${TEMPLETE:-"default.html"} \
}
(return 0 2>/dev/null) || "$(basename "${0%.*}")" "${@}"
