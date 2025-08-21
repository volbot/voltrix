#!/bin/sh

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
BUILD_DIR="./build"
OUTPUT_TITLE="voltrix"
OUTPUT_TITLE_APPEND=""

ANSI_16=()

INPUT_FILE="./build/json/voltrix_raw.json" verbose_level=0
while getopts :i:v flag; do
    case $flag in
        (i) INPUT_FILE=$OPTARG;;
        (v) verbose_level=$((verbose_level + 1));;
        (*) usage
    esac
done
shift "$((OPTIND - 1))"

BLACK_DARK=$( jq -r ."black"."dark" < "$INPUT_FILE" )
BLACK_NORM=$( jq -r ."black"."normal" < "$INPUT_FILE" )
BLACK_BRIG=$( jq -r ."black"."bright" < "$INPUT_FILE" )
RED_DARK=$( jq -r ."red"."dark" < "$INPUT_FILE" )
RED_NORM=$( jq -r ."red"."normal" < "$INPUT_FILE" )
RED_BRIG=$( jq -r ."red"."bright" < "$INPUT_FILE" )
GREEN_DARK=$( jq -r ."green"."dark" < "$INPUT_FILE" )
GREEN_NORM=$( jq -r ."green"."normal" < "$INPUT_FILE" )
GREEN_BRIG=$( jq -r ."green"."bright" < "$INPUT_FILE" )
YELLOW_DARK=$( jq -r ."yellow"."dark" < "$INPUT_FILE" )
YELLOW_NORM=$( jq -r ."yellow"."normal" < "$INPUT_FILE" )
YELLOW_BRIG=$( jq -r ."yellow"."bright" < "$INPUT_FILE" )
BLUE_DARK=$( jq -r ."blue"."dark" < "$INPUT_FILE" )
BLUE_NORM=$( jq -r ."blue"."normal" < "$INPUT_FILE" )
BLUE_BRIG=$( jq -r ."blue"."bright" < "$INPUT_FILE" )
MAGENTA_DARK=$( jq -r ."magenta"."dark" < "$INPUT_FILE" )
MAGENTA_NORM=$( jq -r ."magenta"."normal" < "$INPUT_FILE" )
MAGENTA_BRIG=$( jq -r ."magenta"."bright" < "$INPUT_FILE" )
CYAN_DARK=$( jq -r ."cyan"."dark" < "$INPUT_FILE" )
CYAN_NORM=$( jq -r ."cyan"."normal" < "$INPUT_FILE" )
CYAN_BRIG=$( jq -r ."cyan"."bright" < "$INPUT_FILE" )
ORCHID_DARK=$( jq -r ."orchid"."dark" < "$INPUT_FILE" )
ORCHID_NORM=$( jq -r ."orchid"."normal" < "$INPUT_FILE" )
ORCHID_BRIG=$( jq -r ."orchid"."bright" < "$INPUT_FILE" )
WHITE_DARK=$( jq -r ."white"."dark" < "$INPUT_FILE" )
WHITE_NORM=$( jq -r ."white"."normal" < "$INPUT_FILE" )
WHITE_BRIG=$( jq -r ."white"."bright" < "$INPUT_FILE" )

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

make () {
    case "$1" in
        "kitty")
            OUTPUT_FILETYPE="conf"

            write() {
                echo "# hardcoded fg and bg" 
                echo "foreground ${WHITE_BRIG}"
                echo "background ${BLACK_DARK}"

                echo "# black"
                echo "color0  ${BLACK_DARK}"
                echo "color8  ${WHITE_DARK}"

                echo "# red"
                echo "color1  ${RED_NORM}"
                echo "color9  ${RED_BRIG}"

                echo "# green"
                echo "color2  ${GREEN_NORM}"
                echo "color10 ${GREEN_BRIG}"

                echo "# yellow"
                echo "color3  ${YELLOW_NORM}"
                echo "color11 ${YELLOW_BRIG}"

                echo "# blue"
                echo "color4  ${BLUE_NORM}"
                echo "color12 ${BLUE_BRIG}"

                echo "# magenta"
                echo "color5  ${MAGENTA_NORM}"
                echo "color13 ${MAGENTA_BRIG}"

                echo "# cyan"
                echo "color6  ${CYAN_NORM}"
                echo "color14 ${CYAN_BRIG}"

                echo "# white"
                echo "color7  ${WHITE_NORM}"
                echo "color15 ${WHITE_BRIG}"
            }
        ;;
    "alacritty")
        OUTPUT_FILETYPE="toml"

        write() {
            echo "# Normal colors"
            echo "[colors.normal]"
            echo "black   = '${BLACK_DARK}'"
            echo "red     = '${RED_NORM}'"
            echo "green   = '${GREEN_NORM}'"
            echo "yellow  = '${YELLOW_NORM}'"
            echo "blue    = '${BLUE_NORM}'"
            echo "magenta = '${MAGENTA_NORM}'"
            echo "cyan    = '${CYAN_NORM}'"
            echo "white   = '${WHITE_NORM}'"

            echo "# Bright colors"
            echo "[colors.bright]"
            echo "black   = '${WHITE_DARK}'"
            echo "red     = '${RED_BRIG}'"
            echo "green   = '${GREEN_BRIG}'"
            echo "yellow  = '${YELLOW_BRIG}'"
            echo "blue    = '${BLUE_BRIG}'"
            echo "magenta = '${MAGENTA_BRIG}'"
            echo "cyan    = '${CYAN_BRIG}'"
            echo "white   = '${WHITE_BRIG}'"

            echo "[colors.primary] #default"
            echo "background = '${BLACK_DARK}'"
            echo "foreground = '${WHITE_BRIG}'"

            echo "[colors.cursor]"
            echo "cursor  = '#009845'"
            echo "text    = '${WHITE_BRIG}'"

            echo "[colors.selection]"
            echo "background  = '#68228B'"
            echo "text        = '${WHITE_BRIG}'"
        }
    ;;
"nvim")
    OUTPUT_FILETYPE="lua"
    OUTPUT_TITLE_APPEND="_generated"

    write() {
        echo "local generated = {} "
        echo " generated.palette = { "
        echo "     dark0_hard = \"${BLACK_DARK}\", "
        echo "     dark0 = \"${BLACK_NORM}\", "
        echo "     dark0_soft = \"${BLACK_BRIG}\", "
        echo "     dark1 = \"#3c3836\", "
        echo "     dark2 = \"#504945\", "
        echo "     dark3 = \"#665c54\", "
        echo "     dark4 = \"#7c6f64\", "
        echo "     light0_hard = \"#f9f5d7\", "
        echo "     light0 = \"#fbf1c7\", "
        echo "     light0_soft = \"#f2e5bc\", "
        echo "     light1 = \"#ebdbb2\", "
        echo "     light2 = \"#d5c4a1\", "
        echo "     light3 = \"#bdae93\", "
        echo "     light4 = \"#a89984\", "
        echo "     bright_red = \"${RED_BRIG}\", "
        echo "     bright_green = \"${GREEN_BRIG}\", "
        echo "     bright_yellow = \"${YELLOW_BRIG}\", "
        echo "     bright_blue = \"${BLUE_BRIG}\", "
        echo "     bright_purple = \"${MAGENTA_BRIG}\", "
        echo "     bright_aqua = \"${CYAN_BRIG}\", "
        echo "     bright_orchid = \"${ORCHID_BRIG}\", "
        echo "     neutral_red = \"${RED_NORM}\", "
        echo "     neutral_green = \"${GREEN_NORM}\", "
        echo "     neutral_yellow = \"${YELLOW_NORM}\", "
        echo "     neutral_blue = \"${BLUE_NORM}\", "
        echo "     neutral_purple = \"${MAGENTA_NORM}\", "
        echo "     neutral_aqua = \"${CYAN_NORM}\", "
        echo "     neutral_orchid = \"${ORCHID_NORM}\", "
        echo "     faded_red = \"#9d0006\", "
        echo "     faded_green = \"#79740e\", "
        echo "     faded_yellow = \"#b57614\", "
        echo "     faded_blue = \"#076678\", "
        echo "     faded_purple = \"#8f3f71\", "
        echo "     faded_aqua = \"#427b58\", "
        echo "     faded_orchid = \"#af3a03\", "
        echo "     dark_red_hard = \"#792329\", "
        echo "     dark_red = \"${RED_DARK}\", "
        echo "     dark_red_soft = \"#7b2c2f\", "
        echo "     light_red_hard = \"#fc9690\", "
        echo "     light_red = \"#fc9487\", "
        echo "     light_red_soft = \"#f78b7f\", "
        echo "     dark_green_hard = \"#5a633a\", "
        echo "     dark_green = \"${GREEN_DARK}\", "
        echo "     dark_green_soft = \"#686d43\", "
        echo "     light_green_hard = \"#d3d6a5\", "
        echo "     light_green = \"#d5d39b\", "
        echo "     light_green_soft = \"#cecb94\", "
        echo "     dark_aqua_hard = \"#3e4934\", "
        echo "     dark_aqua = \"${CYAN_DARK}\", "
        echo "     dark_aqua_soft = \"#525742\", "
        echo "     light_aqua_hard = \"#e6e9c1\", "
        echo "     light_aqua = \"#e8e5b5\", "
        echo "     light_aqua_soft = \"#e1dbac\", "
        echo "     gray = \"${WHITE_DARK}\", "
        echo " } "
        echo " return generated "

    }
;;
"vim")
    OUTPUT_FILETYPE="colortemplate"

    write () {
        echo "; vim: ft=colortemplate "
        echo
        echo "; Information {{{"
        echo "Full name: voltrix"
        echo "Short name: voltrix"
        echo "Author: allomyrina volbot <tech@volbot.org>"
        echo "Description: a sweet, maximalist colorscheme for Vim"
        echo "; }}}"
        echo
        echo "Environments: gui 256 16 8"
        echo "Background: dark"
        echo
        echo "; voltrix Color palette {{{"
        echo "; Color name         GUI                  Base256           Base16"
        echo "Color: black         ${BLACK_NORM}        ~                 Black"
        echo "Color: pink          ${RED_NORM}          ~                 Red"
        echo "Color: green         ${GREEN_NORM}        ~                 Green"
        echo "Color: gorod         ${YELLOW_NORM}       ~                 Yellow"
        echo "Color: blue          ${BLUE_NORM}         ~                 Blue"
        echo "Color: orchid        ${MAGENTA_NORM}      ~                 Magenta"
        echo "Color: aqua          ${CYAN_NORM}         ~                 Cyan"
        echo "Color: lightgray     ${WHITE_NORM}        ~                 LightGray"
        echo "Color: gray          ${WHITE_DARK}        ~                 DarkGray"
        echo "Color: lightpink     ${RED_BRIG}          ~                 LightRed"
        echo "Color: lightgreen    ${GREEN_BRIG}        ~                 LightGreen"
        echo "Color: lightgorod    ${YELLOW_BRIG}       ~                 LightYellow"
        echo "Color: lightblue     ${BLUE_BRIG}         ~                 LightBlue"
        echo "Color: lightorchid   ${MAGENTA_BRIG}      ~                 LightMagenta"
        echo "Color: lightaqua     ${CYAN_BRIG}         ~                 LightCyan"
        echo "Color: white         ${WHITE_BRIG}        ~                 White"
        echo "Color: truegreen     #009845              ~                 Green"
        echo "Color: royalpurple   #68228B              ~                 Magenta"
        echo "Color: burntorange   #de6047              ~                 Red"
        echo "; }}}"
        echo
        echo "; voltrix Terminal colors {{{"
        echo "; Define terminal colors (for immersion)"
        echo "Term colors: black pink green gorod blue orchid aqua lightgray gray lightpink lightgreen lightgorod lightblue lightorchid lightaqua white"
        echo "; }}}"
        echo
        echo "; voltrix Linked groups {{{"
        echo "Boolean           -> Constant"
        echo "Character         -> Constant"
        echo "Conditional       -> Statement"
        echo "CursorLineFold    -> FoldColumn"
        echo "Debug             -> Special"
        echo "Define            -> PreProc"
        echo "Delimiter         -> Special"
        echo "EndOfBuffer       -> NonText"
        echo "Exception         -> Statement"
        echo "Float             -> Number"
        echo "Function          -> Identifier"
        echo "Include           -> PreProc"
        echo "Keyword           -> Statement"
        echo "Label             -> Statement"
        echo "Macro             -> PreProc"
        echo "MessageWindow     -> WarningMsg"
        echo "Number            -> Constant"
        echo "Operator          -> Statement"
        echo "PmenuKind         -> Pmenu"
        echo "PmenuKindSel      -> PmenuSel"
        echo "PmenuExtra        -> Pmenu"
        echo "PmenuExtraSel     -> PmenuSel"
        echo "PopupNotification -> WarningMsg"
        echo "PopupSelected     -> PmenuSel"
        echo "PreCondit         -> PreProc"
        echo "QuickFixLine      -> Search"
        echo "Repeat            -> Statement"
        echo "SpecialChar       -> Special"
        echo "SpecialComment    -> Special"
        echo "StorageClass      -> Type"
        echo "String            -> Constant"
        echo "Structure         -> Type"
        echo "Tag               -> Special"
        echo "Typedef           -> Type"
        echo "lCursor           -> Cursor"
        echo "; }}}"
        echo
        echo "; voltrix Highlight groups {{{"
        echo "Normal               white               none"
        echo "Terminal             white               none"
        echo "CursorLine           omit                black"
        echo "StatusLineTerm       white               royalpurple       bold"
        echo "StatusLineTermNC     lightgray           truegreen         bold"
        echo "; Group              Foreground          Background        Attributes"
        echo "; vim specific"
        echo "ColorColumn          omit                black"
        echo "Cursor               fg                  truegreen"
        echo "CursorColumn         omit                black"
        echo "CursorLineNr         omit                black             bold"
        echo "FoldColumn           none                black"
        echo "Folded               white               gray "
        echo "IncSearch            white               royalpurple"
        echo "LineNr               gorod               none              bold"
        echo "Search               white               truegreen"
        echo "Visual               fg                  royalpurple"
        echo "StatusLine           white               royalpurple       bold"
        echo "StatusLineNC         lightgray           gray              bold"
        echo "ToolbarLine          white               black"
        echo "ToolbarButton        white               truegreen         bold"
        echo "SignColumn           none                gray"
        echo "; version control integration"
        echo "DiffAdd              gray                green             bold"
        echo "DiffChange           gray                pink              bold"
        echo "DiffDelete           gray                burntorange       bold"
        echo "DiffText             white               aqua              reverse"
        echo "; general syntax highlights"
        echo "Comment              aqua                none"
        echo "Constant             orchid              none"
        echo "Error                lightgray           burntorange"
        echo "Identifier           pink                none              "
        echo "Ignore               black               none"
        echo "PreProc              blue                none"
        echo "Special              pink                none              bold"
        echo "Statement            gorod               none              "
        echo "/gui		     omit		 omit		   bold"
        echo "Type                 green               none              bold"
        echo "Underlined           blue                none              underline"
        echo "; }}}"
    }
;;
*)
    echo "Unknown argument: $arg"
    return 1
    ;;
esac

OUTPUT_FILE=''
acquire_file OUTPUT_FILE "$1" "$OUTPUT_FILETYPE"

[[ "$verbose_level" -gt 0 ]] && echo "Writing config for '${1}' to 'build/${OUTPUT_FILE}'"

write > "${BUILD_DIR}/${OUTPUT_FILE}"

OUTPUT_TITLE_APPEND=""

return 0

}

mkdir -p build

ARGS=( "$@" )
OPTIONS=("kitty" "alacritty" "nvim")

if [[ $# -eq 0 || "$ARGS" == *"all"* ]]; then
    ARGS=("${OPTIONS[@]}")
fi

for arg in "${ARGS[@]}"; do
    make "$arg"
    [[ "$verbose_level" -gt 0 ]] && echo "make ${arg} SUCCESSFUL"
done

exit 0
