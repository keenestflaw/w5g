port-mkdn2html-positional2named_parameter() {
source io-cli-read_positional_arguments.bash
io-cli-read_positional_arguments "${@}"

local -ra _names_=(OUTPUT_FILE INPUT_FILE METADATA_FILE)
local  -a configuration_items=()

for j in ${!_names_[@]}; do
    configuration_items[$j]="${_names_[$j]}=${arguments[$j]}"
done

for key_value_pair in ${configuration_items[@]}; do
    printf "%s\n" "${key_value_pair}" 
done    
}
(return 0 2>/dev/null) || "$(basename "${0%.*}")" "${@}"
