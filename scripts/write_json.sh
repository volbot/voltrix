#!/bin/sh

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
BUILD_DIR="./build"
OUTPUT_TITLE="voltrix"
OUTPUT_TITLE_APPEND=""

verbose_level=0
while getopts :v flag; do
    case $flag in
        (v) verbose_level=$((verbose_level + 1));;
        (*) usage
    esac
done
shift "$((OPTIND - 1))"

COLORS=( "black" "red" "green" "yellow" "blue" "magenta" "cyan" "white" "orchid" )
HUES=( 300 340 100 40 220 280 160 300 310)

mkdir -p "$BUILD_DIR"

acquire_file () {
    mkdir -p "${BUILD_DIR}/${2}"
    _OUTPUT_FILE="${2}/${OUTPUT_TITLE}${OUTPUT_TITLE_APPEND}.${3}"
    if [ -f "${BUILD_DIR}/${_OUTPUT_FILE}" ]; then
        [[ "$verbose_level" -gt 0 ]] && echo "File exists: ${_OUTPUT_FILE}"
        [[ "$verbose_level" -gt 0 ]] && echo "Moving it to ${_OUTPUT_FILE}.old"
        mv "${BUILD_DIR}/${_OUTPUT_FILE}" "${BUILD_DIR}/${_OUTPUT_FILE}.old"
    fi
    eval "$1='${_OUTPUT_FILE}'"
}

write () {
    echo "{"
    echo "    \"${COLORS[0]}\": {"
    echo "        \"dark\": \"$(pastel format hex hsl\(${HUES[0]},\ 20.0%,\ 2.9%\))\","
    echo "        \"normal\": \"$(pastel format hex hsl\(${HUES[0]},\ 20.0%,\ 12.9%\))\","
    echo "        \"bright\": \"$(pastel format hex hsl\(${HUES[0]},\ 20.0%,\ 22.9%\))\""
    echo "    },"
    for i in {1..6}; do
        echo "    \"${COLORS[${i}]}\": {"
        echo "        \"dark\": \"$(pastel format hex hsl\(${HUES[${i}]},\ 69.6%,\ 37.5%\))\","
        echo "        \"normal\": \"$(pastel format hex hsl\(${HUES[${i}]},\ 69.6%,\ 47.5%\))\","
        echo "        \"bright\": \"$(pastel format hex hsl\(${HUES[${i}]},\ 69.6%,\ 57.5%\))\""
        echo "    },"
    done
    echo "    \"${COLORS[7]}\": {"
    echo "        \"dark\": \"$(pastel format hex hsl\(${HUES[7]},\ 5.0%,\ 50.0%\))\","
    echo "        \"normal\": \"$(pastel format hex hsl\(${HUES[7]},\ 5.0%,\ 70.0%\))\","
    echo "        \"bright\": \"$(pastel format hex hsl\(${HUES[7]},\ 5.0%,\ 99.9%\))\""
    echo "    }"
    echo "}"
}

mkdir -p build

OUTPUT_FILETYPE='json'
OUTPUT_FILE=''
OUTPUT_TITLE_APPEND='_raw'
acquire_file OUTPUT_FILE "json" "$OUTPUT_FILETYPE"

[[ "$verbose_level" -gt 0 ]] && echo "Writing generated colors to 'build/json/${OUTPUT_FILE}'"

write > "${BUILD_DIR}/${OUTPUT_FILE}"

exit 0
