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

COLORS=( "red" "green" "yellow" "blue" "magenta" "cyan" "orchid" "orange" )
HUES=( 340 100 40 220 280 160 310 20 )

BLACK_HUE=257
WHITE_HUE=257

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
    for i in ${!COLORS[@]}; do
        echo "    \"${COLORS[${i}]}\": {"
        echo "        \"dark\": \"$(pastel format hex hsl\(${HUES[${i}]},\ 69.6%,\ 47.5%\))\","
        echo "        \"normal\": \"$(pastel format hex hsl\(${HUES[${i}]},\ 69.6%,\ 57.5%\))\","
        echo "        \"bright\": \"$(pastel format hex hsl\(${HUES[${i}]},\ 69.6%,\ 67.5%\))\""
        echo "    },"
    done
    echo "    \"black\": {"
    # can't decide between black base lightness at 5% or 9.8%. leaning toward 5%
    echo "        \"dark\": \"$(pastel format hex hsl\(${BLACK_HUE},\ 28.0%,\ 5.0%\))\","
    echo "        \"normal\": \"$(pastel format hex hsl\(${BLACK_HUE},\ 28.0%,\ 15.0%\))\","
    echo "        \"bright\": \"$(pastel format hex hsl\(${BLACK_HUE},\ 28.0%,\ 25.0%\))\""
    echo "    },"
    echo "    \"bg\": {"
    echo "        \"zero\": \"$(pastel format hex hsl\(${BLACK_HUE},\ 28.0%,\ 5.0%\))\","
    echo "        \"one\": \"$(pastel format hex hsl\(${BLACK_HUE},\ 20.7%,\ 23.7%\))\","
    echo "        \"two\": \"$(pastel format hex hsl\(${BLACK_HUE},\ 20.4%,\ 25.5%\))\","
    echo "        \"three\": \"$(pastel format hex hsl\(${BLACK_HUE},\ 20.4%,\ 28.6%\))\","
    echo "        \"four\": \"$(pastel format hex hsl\(${BLACK_HUE},\ 20.9%,\ 30.8%\))\""
    echo "    },"
    echo "    \"white\": {"
    echo "        \"dark\": \"$(pastel format hex hsl\(${WHITE_HUE},\ 15.0%,\ 60.0%\))\","
    echo "        \"normal\": \"$(pastel format hex hsl\(${WHITE_HUE},\ 10.0%,\ 75.0%\))\","
    echo "        \"bright\": \"$(pastel format hex hsl\(${WHITE_HUE},\ 5.0%,\ 99.9%\))\""
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
