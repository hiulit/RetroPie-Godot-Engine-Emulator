#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="godot-engine"
rp_module_desc="Godot - Game Engine (https://godotengine.org/)"
rp_module_help="Godot games extensions: .pck .zip."
rp_module_help+="\n\nCopy your Godot games to:\n'$romdir/godot-engine'."
rp_module_help+="\n\nAuthor: hiulit (https://github.com/hiulit)."
rp_module_help+="\n\nCredits: https://github.com/hiulit/RetroPie-Godot-Game-Engine-Emulator#credits"
rp_module_help+="\n\nLicense: https://github.com/hiulit/RetroPie-Godot-Game-Engine-Emulator#license"
rp_module_licence="MIT https://raw.githubusercontent.com/hiulit/RetroPie-Godot-Game-Engine-Emulator/master/LICENSE"
rp_module_section="opt"
rp_module_flags="x86 aarch64 rpi1 rpi2 rpi3"

godot_versions=(
    "2.1.6"
    "3.0.6"
    "3.1.0"
    "3.1.1"
)

function _dialog_yesno() {
    local title="$1"
    local message="$2"
    local dialog_height="$3"
    local dialog_width="$4"
    [[ -z "$title" ]] && echo "ERROR: '${FUNCNAME[0]}' needs a title as an argument!" && exit 1
    [[ -z "$message" ]] && echo "ERROR: '${FUNCNAME[0]}' needs a message as an argument!" && exit 1
    [[ -z "$dialog_height" ]] && dialog_height=8
    [[ -z "$dialog_width" ]] && dialog_width="$DIALOG_WIDTH"
    dialog \
        --backtitle "$DIALOG_BACKTITLE" \
        --title "$1" \
        --yesno "$2" "$dialog_height" "$dialog_width" 2>&1 >/dev/tty
}


function _download_file() {
    local build_file="$file"

    [[ "$platform" != "x11_32" ]] && build_file="godot_$file"
    
    echo "> Dowloading '$build_file'..."
    echo
    curl -LJO "$url/$file" -o "$md_build/$build_file"
    if [[ "$?" -eq 0 ]]; then
        chmod +x "$md_build/$build_file"
        echo
        echo "'$file' downloaded succsesfully!"
        echo
    else
        echo
        echo "Something went wrong when dowloading '$file'."
        echo
    fi
}


function sources_godot-engine() {
    local url="https://github.com/hiulit/RetroPie-Godot-Game-Engine-Emulator/raw/master/bin"
    local platform
    local file

    for version in "${godot_versions[@]}"; do
        if isPlatform "x86"; then
            platform="x11_32"
            file="godot_${version}_${platform}.bin"
            _download_file
        elif isPlatform "aarch64"; then
            platform="arm64"
            file="frt_${version}_${platform}.bin"
            _download_file
        elif isPlatform "rpi1"; then
            platform="pi1"
            file="frt_${version}_${platform}.bin"
            _download_file
        elif isPlatform "rpi2" || isPlatform "rpi3"; then
            platform="pi2"
            file="frt_${version}_${platform}.bin"
            _download_file
        fi
    done
}


function install_godot-engine() {
    if [[ -d "$md_build" ]]; then
        md_ret_files=($(ls "$md_build"))
    fi
}


function configure_godot-engine() {
    mkRomDir "godot-engine"

    local bin_file
    local bin_files
    local default
    local id
    local index
    local version

    local use_frt="$1"
    local frt_keyboard="$2"

    if [[ -d "$md_inst" ]]; then
        bin_files=($(ls "$md_inst"))
    fi

    if isPlatform "x86"; then
        id="x86"
    elif isPlatform "aarch64"; then
        id="frt-arm64"
    elif isPlatform "rpi1"; then
        id="frt-rpi0-1"
    elif isPlatform "rpi2" || isPlatform "rpi3"; then
        id="frt-rpi2-3"
    fi

    for index in "${!bin_files[@]}"; do
        default=0
        [[ "$index" -eq "${#bin_files[@]}-1" ]] && default=1 # Default to the last item in 'bin_files'.
        
        version="${bin_files[$index]}"
        version="$(echo $version | cut -d'_' -f 2)"
        
        if [[ "$id" != "x86" && $use_frt -eq 1 ]]; then
            addEmulator "$default" "$md_id-$version-$id" "godot-engine" "FRT_KEYBOARD_ID='$frt_keyboard' $md_inst/${bin_files[$index]} --main-pack %ROM%"
        else
            addEmulator "$default" "$md_id-$version-$id" "godot-engine" "$md_inst/${bin_files[$index]} --main-pack %ROM%"
        fi
    done

    addSystem "godot-engine" "Godot" ".pck .zip"
}

function gui_godot-engine() {
    local i=1
    local options=()
    local cmd
    local choice

    local use_frt=0
    local frt_keyboard

    dialog \
        --backtitle "Godot - Game Engine Configuration" \
        --title "" \
        --yesno "Would you like you use a GPIO/Virtual keyboard?" 10 60 2>&1 >/dev/tty

    if [[ "$?" -eq 0 ]]; then
        while IFS= read -r line; do
            line="$(echo "$line" | sed -e 's/^"//' -e 's/"$//')" # Remove leading and trailing double quotes.
            options+=("$i" "$line")
            ((i++))
        done < <(cat "/proc/bus/input/devices" | grep "N: Name" | cut -d= -f2)

        cmd=(dialog \
            --backtitle "Godot - Game Engine Configuration" \
            --title "" \
            --ok-label "OK" \
            --cancel-label "Exit" \
            --menu "Choose an option." \
            15 60 15)

        choice="$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)"

        if [[ "$?" -eq 0 ]]; then
            use_frt=1
            frt_keyboard="${options[choice*2-1]}"
            configure_godot-engine "$use_frt" "$frt_keyboard"
        else
            use_frt=0
            configure_godot-engine "$use_frt"
        fi
    fi
}
