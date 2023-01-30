#!/usr/bin/env bash
exit_with(){
set -euo pipefail
#? parameter: see below
local -r _command_failed_="${1}"
local -r _with_description_="${2}"
local -r _using_attribute_="${3}"
local -r _caused_by_assumption_="${4}"
local -r _status_code_="${5}"
printf "%s: %s '%s': %s (%s)\n"\
            "${_command_failed_} \
             $(basename ${0})->${FUNCNAME[1]:-${FUNCNAME}}" \
             "${_with_description_}" "${_using_attribute_}" \
             "${_caused_by_assumption_}" \
             "${_status_code_}" >&2
exit "${_status_code_}" 
}
