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
rp_module_help+="\n\nCredits: Emanuele Fornara (https://github.com/efornara) for creating \"FRT - A Godot 'platform' targeting single board computers\" (https://github.com/efornara/frt)."
rp_module_licence="MIT https://raw.githubusercontent.com/hiulit/RetroPie-Godot-Game-Engine-Emulator/master/LICENSE"
rp_module_section="opt"
rp_module_flags="x86 aarch64 rpi1 rpi2 rpi3"


function sources_godot-engine() {
    gitPullOrClone "$md_build" "https://github.com/hiulit/RetroPie-Godot-Game-Engine-Emulator.git" "develop"
}


function install_godot-engine() {
    if isPlatform "x86"; then
        md_ret_files=("bin/godot-3.0-x11-x86-32.bin" "bin/godot-3.1-x11-x86-32.bin")
    elif isPlatform "aarch64"; then
        md_ret_files="bin/frt_094_310_arm64.bin"
    elif isPlatform "rpi1"; then
        md_ret_files="bin/frt_094_310_pi1.bin"
    elif isPlatform "rpi2" || isPlatform "rpi3"; then
        md_ret_files="bin/frt_094_310_pi2.bin"
    fi
}


function configure_godot-engine() {
    mkRomDir "godot-engine"

    local bin_files
    local bin_file
    local id

    if isPlatform "x86"; then
        bin_files=("godot-3.0-x11-x86-32.bin" "godot-3.1-x11-x86-32.bin")
    elif isPlatform "aarch64"; then
        bin_file="frt_094_310_arm64.bin"
        id="arm64"
    elif isPlatform "rpi1"; then
        bin_file="frt_094_310_pi1.bin"
        id="rpi0-1"
    elif isPlatform "rpi2" || isPlatform "rpi3"; then
        bin_file="frt_094_310_pi2.bin"
        id="rpi2-3"
    fi

    if isPlatform "x86"; then
        addEmulator 0 "godot-engine-3.0" "godot-engine" "$md_inst/${bin_files[0]} --main-pack %ROM%"
        addEmulator 1 "godot-engine-3.1" "godot-engine" "$md_inst/${bin_files[1]} --main-pack %ROM%"
    else
        addEmulator 1 "godot-engine-$id" "godot-engine" "$md_inst/$bin_file --main-pack %ROM%"
    fi

    addSystem "godot-engine" "Godot" ".pck .zip"
}
