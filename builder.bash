
builder() {
    set -o nounset
    [[ -z ${1} ]]

#pandoc \
#    --from=markdown "${INPUT_FILE}" \
#    --to=html --output="${OUTPUT_FILE}" \
#    --metadata-file=${METADATA_FILE} \
#    --data-dir=${DATA_DIR} \
#    --standalone  --verbose --trace 
##    --template=${TEMPLETE:-"default.html"} \
}
(return 0 2>/dev/null) || "$(basename "${0%.*}")" "${@}"