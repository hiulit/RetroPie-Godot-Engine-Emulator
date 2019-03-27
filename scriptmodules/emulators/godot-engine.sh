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
rp_module_desc="Godot - Game Engine"
rp_module_help="Godot game extensions: .pck .zip."
rp_module_help+="\n\nCopy your Godot games to '$romdir/$rp_module_id'."
rp_module_help+="\n\nAuthor: hiulit - https://github.com/hiulit."
rp_module_help+="\n\nCredits: Emanuele Fornara (https://github.com/efornara) for creating FRT - A Godot 'platform' targeting single board computers. (https://github.com/efornara/frt)."
rp_module_licence="MIT https://raw.githubusercontent.com/hiulit/RetroPie-Godot-Game-Engine-Emulator/master/LICENSE"
rp_module_section="opt"
rp_module_flags="x86 aarch64 rpi1 rpi2 rpi3"


function sources_godot-engine() {
    gitPullOrClone "$md_build" "https://github.com/hiulit/RetroPie-Godot-Game-Engine-Emulator.git"
}


function install_godot-engine() {
    if isPlatform "x86"; then
        md_ret_files="bin/godot.x11.opt.32.bin"
    elif isPlatform "aarch64"; then
        md_ret_files="bin/frt_094_310_arm64.bin"
    elif isPlatform "rpi1"; then
        md_ret_files="bin/frt_094_310_pi1.bin"
    elif isPlatform "rpi2" || isPlatform "rpi3"; then
        md_ret_files="bin/frt_094_310_pi2.bin"
    fi
}


function configure_godot-engine() {
    mkRomDir "$rp_module_id"

    local bin_file

    if isPlatform "x86"; then
        bin_file="godot.x11.opt.32.bin"
    elif isPlatform "aarch64"; then
        bin_file="frt_094_310_arm64.bin"
    elif isPlatform "rpi1"; then
        bin_file="frt_094_310_pi1.bin"
    elif isPlatform "rpi2" || isPlatform "rpi3"; then
        bin_file="frt_094_310_pi2.bin"
    fi

    addEmulator 1 "$md_id" "$rp_module_id" "$md_inst/$bin_file --main-pack %ROM%"
    addSystem "$rp_module_id" "Godot" ".pck .zip"
}
