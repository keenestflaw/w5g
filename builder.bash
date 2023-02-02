
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
# check validity of input args
#    local -ra _builder_env_names_=('INPUT_FILE' 'OUTPUT_FILE' 'METADATA_FILE' 'STANDALONE_OR_PARTIAL')
#    local -ra _builder_env_keys_and_values_=("${1}" "${2}" "${3}")
#
#    local  -a test_configuration_items=()
#    for key in "${!_builder_env_names_[@]}"; do
#        test_configuration_items+=("${_builder_env_names_[$key]}=${_builder_env_keys_and_values_[$key]}")
#    done
#
#
#    local -A runtime_properties
#    local  -a runtime_configuration_items=()
#    for key in "${@}"; do
#        runtime_properties+=([${key}]+="${!key}")
#        runtime_configuration_items+=("${key}=${!key}")
#    done

    source <(printf "%s\n" "${@}")
#    printf -v builder_cli_args '%s' \
#"--from=markdown ${INPUT_FILE} \
#--to=html --output=${OUTPUT_FILE} \
#--metadata-file=${METADATA_FILE} \
#${STANDALONE_OR_PARTIAL} \
#--verbose"
    pandoc \
        --from=markdown ${INPUT_FILE} \
        --to=html --output=${OUTPUT_FILE} \
        --metadata-file=${METADATA_FILE} \
        ${STANDALONE_OR_PARTIAL} \
        --verbose

#    BUILDER=pandoc
#    printf -v builder_cmd "%s %s\n" "${BUILDER}" "${builder_cli_args}"
#    printf  "%s\n%s\n" "#!/usr/bin/env bash" "${builder_cmd}" > /tmp/builder_cli_args.bash
#    $( bash -c "${builder_cmd}")
}


(return 0 2>/dev/null) || "$(basename "${0%.*}")" "${@}"