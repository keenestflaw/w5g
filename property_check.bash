
property_check() {
    set -o errexit
    set -o nounset
 
    local -A runtime_properties
    local  -a runtime_configuration_items=()
    for key in "${@}"; do
        runtime_properties+=([${key}]+="${!key}")
        runtime_configuration_items+=("${key}=${!key}")
    done
    local runtime_environment=''
    printf -v runtime_environment "%s" "${runtime_configuration_items[@]}" 
    printf -v runtime_checksum "%s" "$(sha256sum <<< "${runtime_environment}")"
    printf "%s\n%s\n" "${runtime_environment}" "${runtime_checksum}"
}
(return 0 2>/dev/null) || "$(basename "${0%.*}")" "${@}"