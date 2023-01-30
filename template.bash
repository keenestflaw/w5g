
template() {
    set -o nounset
    [[ -z ${1} ]]
}
(return 0 2>/dev/null) || "$(basename "${0%.*}")" "${@}"