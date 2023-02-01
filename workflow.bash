
workflow() {
    set -o errexit
    set -o nounset
    source <(printf "%s\n" "${@}")
    printf -v environment "%s\n%s\n" "PROJECT_DIR=${PROJECT_DIR}" "FOO=${FOO}"
    printf "%s\n" "$(sha256sum <<< "${environment}")"

    return 0
}

(return 0 2>/dev/null) || "$(basename "${0%.*}")" "${@}"