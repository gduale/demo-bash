#!/bin/bash

# gduale - 2018/10/25

function exit_on_fail() {
  echo ${1}
  exit 2
}

function usage() {
  echo "This script check the memory available on the requested ESX."
  echo "Usage : $0 -h <esx name> -w <threshold warning in GB> -c <threshold critical in GB>"
  exit 1
}

# Deal with script's options
while getopts "w:h:c:" option; do
  case "${option}" in
    w)
      w=${OPTARG}
      ;;
    c)
      c=${OPTARG}
      ;;
    h)
      h=${OPTARG}
      ;;
    *)
      usage
      ;;
  esac
done
shift $((OPTIND-1))
if [ -z "${w}" ] || [ -z "${h}" ] || [ -z "${c}" ]; then
  usage
fi
echo "h = ${h}"
echo "w = ${w}"
echo "c = ${c}"

(("$c" > "$w")) || exit_on_fail "The CRITICAL value is inferior than WARNING"
