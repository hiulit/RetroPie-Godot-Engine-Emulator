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
    md_ret_files=($(ls .))
}


function configure_godot-engine() {
    mkRomDir "godot-engine"

    local bin_file
    local bin_files
    local default
    local id
    local index
    local version

    bin_files=($(ls .))

    for index in "${!bin_files[@]}"; do
        default=0
        [[ "$index" -eq "${#bin_files[@]}-1" ]] && default=1 # Default to the last item in 'bin_files'.
        
        version="${bin_files[$index]}"
        version="$(echo $version | cut -d'_' -f 2)"
        
        addEmulator "$default" "$md_id-$version-$id" "godot-engine" "$md_inst/${bin_files[$index]} --main-pack %ROM%"
    done

    addSystem "godot-engine" "Godot" ".pck .zip"
}
