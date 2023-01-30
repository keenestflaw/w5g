port-mkdn2html-positional2named_parameter() {
source io-cli-read_positional_arguments.bash
io-cli-read_positional_arguments "${@}"

local -a configuration_items=(OUTPUT_FILE INPUT_FILE METADATA_FILE)
for j in ${!configuration_items[@]}; do
    configuration_items[$j]+="=${arguments[$j]}"
done

for key_value_pair in ${configuration_items[@]}; do
    printf "%s\n" "${key_value_pair}" 
done    
}
(return 0 2>/dev/null) || "$(basename "${0%.*}")" "${@}"
