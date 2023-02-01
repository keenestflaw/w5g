
template() {
    set -o nounset
}
(return 0 2>/dev/null) || "$(basename "${0%.*}")" "${@}"