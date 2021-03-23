#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

# Scriptmodule variables ############################

rp_module_id="godot-engine"
rp_module_desc="Godot Engine (https://godotengine.org/)."
rp_module_help="Game extensions: .pck .zip."
rp_module_help+="\n\nCopy your games to $romdir/$rp_module_id."
rp_module_help+="\n\nAuthor: hiulit (https://github.com/hiulit)."
rp_module_help+="\n\nRepository: https://github.com/hiulit/RetroPie-Godot-Game-Engine-Emulator"
rp_module_help+="\n\nLicenses:"
rp_module_help+="\n- Source code, Godot Engine and FRT: MIT."
rp_module_help+="\n- Godot logo: CC BY 3.0."
rp_module_help+="\n- Godot pixel logo: CC BY-NC-SA 4.0."
rp_module_licence="MIT https://raw.githubusercontent.com/hiulit/RetroPie-Godot-Game-Engine-Emulator/master/LICENSE"
rp_module_section="opt"
rp_module_flags="x86 x86_64 aarch64 rpi1 rpi2 rpi3 rpi4"


# Global variables ##################################

RP_MODULE_ID="$rp_module_id"
SCRIPT_VERSION="1.4.0"
GODOT_VERSIONS=(
    "2.1.6"
    "3.0.6"
    "3.1.2"
    "3.2.3"
)
FRT_KEYBOARD=""
OVERRIDE_CFG_DEFAULTS_FILE="$romdir/$RP_MODULE_ID/.override_defaults.cfg"
OVERRIDE_CFG_FILE="$romdir/$RP_MODULE_ID/override.cfg"

# Configuration flags ###############################

FRT_FLAG=0
GLES2_FLAG=0


# Configuration dialog variables ####################

readonly DIALOG_OK=0
readonly DIALOG_CANCEL=1
readonly DIALOG_EXTRA=3
readonly DIALOG_ESC=255
readonly DIALOG_BACKTITLE="Godot Engine Configuration"
readonly DIALOG_HEIGHT=8
readonly DIALOG_WIDTH=60


# Configuration dialog functions ####################

function _main_config_dialog() {
    local options=()
    local option_1_enabled_disabled
    local option_2_enabled_disabled
    local cmd
    local choice

    if [[ "$FRT_FLAG" -eq 0 ]]; then
        option_1_enabled_disabled="Disabled"
    elif [[ "$FRT_FLAG" -eq 1 ]]; then
        option_1_enabled_disabled="Enabled"
    fi

    if [[ "$GLES2_FLAG" -eq 0 ]]; then
        option_2_enabled_disabled="Disabled"
    elif [[ "$GLES2_FLAG" -eq 1 ]]; then
        option_2_enabled_disabled="Enabled"
    fi

    options=(
        1 "Use a GPIO/Virtual keyboard ("$option_1_enabled_disabled")"
        2 "Force GLES2 video driver ("$option_2_enabled_disabled")"
        3 "Edit \"override.cfg\""
    )
    cmd=(dialog \
            --backtitle "$DIALOG_BACKTITLE" \
            --title "" \
            --ok-label "OK" \
            --cancel-label "Back" \
            --menu "Choose an option." \
            15 "$DIALOG_WIDTH" 15)
    choice="$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)"
    local return_value="$?"

    if [[ "$return_value" -eq "$DIALOG_OK" ]]; then
        if [[ -n "$choice" ]]; then
            case "$choice" in
                1)
                    _gpio_virtual_keyboard_dialog
                    ;;
                2)
                    _force_gles2_dialog
                    ;;
                3)
                    _edit_override_cfg_dialog
                    ;;
            esac
        fi
    fi
}


function _gpio_virtual_keyboard_dialog() {
    dialog \
        --backtitle "$DIALOG_BACKTITLE" \
        --title "" \
        --yesno "Would you like to you use a GPIO/Virtual keyboard?" "$DIALOG_HEIGHT" "$DIALOG_WIDTH" 2>&1 >/dev/tty
    local return_value="$?"

    if [[ "$return_value" -eq "$DIALOG_OK" ]]; then
        local i=1
        local options=()
        local cmd
        local choice

        while IFS= read -r line; do
            line="$(echo "$line" | sed -e 's/^"//' -e 's/"$//')" # Remove leading and trailing double quotes.
            options+=("$i" "$line")
            ((i++))
        done < <(cat "/proc/bus/input/devices" | grep "N: Name" | cut -d= -f2)

        cmd=(dialog \
            --backtitle "$DIALOG_BACKTITLE" \
            --title "" \
            --ok-label "OK" \
            --cancel-label "Back" \
            --menu "Choose an option." \
            15 "$DIALOG_WIDTH" 15)

        choice="$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)"

        if [[ "$return_value" -eq "$DIALOG_OK" ]]; then
            if [[ -n "$choice" ]]; then
                configure_godot-engine "use_frt" 1 "${options[choice*2-1]}"

                dialog \
                    --backtitle "$DIALOG_BACKTITLE" \
                    --title "" \
                    --ok-label "OK" \
                    --msgbox "The GPIO/Virtual keyboard has been set." "$DIALOG_HEIGHT" "$DIALOG_WIDTH" 2>&1 >/dev/tty

                _main_config_dialog
            else
                # If there is no choice that means the user selected "Back".
                _main_config_dialog
            fi
        elif [[ "$return_value" -eq "$DIALOG_CANCEL" ]]; then
            _main_config_dialog
        elif [[ "$return_value" -eq "$DIALOG_ESC" ]]; then
            _main_config_dialog
        fi
    elif [[ "$return_value" -eq "$DIALOG_CANCEL" ]]; then
        configure_godot-engine "use_frt" 0

        dialog \
            --backtitle "$DIALOG_BACKTITLE" \
            --title "" \
            --ok-label "OK" \
            --msgbox "The GPIO/Virtual keyboard has been unset." "$DIALOG_HEIGHT" "$DIALOG_WIDTH" 2>&1 >/dev/tty

        _main_config_dialog
    elif [[ "$return_value" -eq "$DIALOG_ESC" ]]; then
        _main_config_dialog
    fi
}


function _force_gles2_dialog() {
    dialog \
        --backtitle "$DIALOG_BACKTITLE" \
        --title "" \
        --yesno "Would you like to force Godot to use the GLES2 video driver?" "$DIALOG_HEIGHT" "$DIALOG_WIDTH" 2>&1 >/dev/tty
    local return_value="$?"

    if [[ "$return_value" -eq "$DIALOG_OK" ]]; then
        configure_godot-engine "force_gles2" 1

        dialog \
            --backtitle "$DIALOG_BACKTITLE" \
            --title "" \
            --ok-label "OK" \
            --msgbox "GLES2 video renderer has been set." "$DIALOG_HEIGHT" "$DIALOG_WIDTH" 2>&1 >/dev/tty

        _main_config_dialog
    elif [[ "$return_value" -eq "$DIALOG_CANCEL" ]]; then
        configure_godot-engine "force_gles2" 0

        dialog \
            --backtitle "$DIALOG_BACKTITLE" \
            --title "" \
            --ok-label "OK" \
            --msgbox "GLES2 video renderer has been unset." "$DIALOG_HEIGHT" "$DIALOG_WIDTH" 2>&1 >/dev/tty

        _main_config_dialog
    elif [[ "$return_value" -eq "$DIALOG_ESC" ]]; then
        _main_config_dialog
    fi
}


function _edit_override_cfg_dialog() {
    local override_cfg

    override_cfg="$(dialog \
                    --backtitle "$DIALOG_BACKTITLE" \
                    --title "Edit \"override.cfg\"" \
                    --ok-label "Save" \
                    --cancel-label "Back" \
                    --extra-button \
                    --extra-label "Reset" \
                    --editbox "$OVERRIDE_CFG_FILE" 15 "$DIALOG_WIDTH" 2>&1 >/dev/tty)"
    local return_value="$?"

    if [[ "$return_value" -eq "$DIALOG_OK" ]]; then
        echo "$override_cfg" > "$OVERRIDE_CFG_FILE"

        dialog \
            --backtitle "$DIALOG_BACKTITLE" \
            --title "" \
            --ok-label "OK" \
            --msgbox "\"override.cfg\" updated successfully!" "$DIALOG_HEIGHT" "$DIALOG_WIDTH" 2>&1 >/dev/tty

        _main_config_dialog
    elif [[ "$return_value" -eq "$DIALOG_EXTRA" ]]; then
        dialog \
            --backtitle "$DIALOG_BACKTITLE" \
            --title "" \
            --yesno "Would you like to reset \"override.cfg\" to the default values?" "$DIALOG_HEIGHT" "$DIALOG_WIDTH" 2>&1 >/dev/tty
        local return_value="$?"

        if [[ "$return_value" -eq "$DIALOG_OK" ]]; then
            cat "$OVERRIDE_CFG_DEFAULTS_FILE" > "$OVERRIDE_CFG_FILE"

            dialog \
                --backtitle "$DIALOG_BACKTITLE" \
                --title "" \
                --ok-label "OK" \
                --msgbox "\"override.cfg\" has been reset to the default values." "$DIALOG_HEIGHT" "$DIALOG_WIDTH" 2>&1 >/dev/tty

            _edit_override_cfg_dialog
        elif [[ "$return_value" -eq "$DIALOG_CANCEL" ]]; then
            _edit_override_cfg_dialog
        elif [[ "$return_value" -eq "$DIALOG_ESC" ]]; then
            _edit_override_cfg_dialog
        fi
    elif [[ "$return_value" -eq "$DIALOG_CANCEL" ]]; then
        _main_config_dialog
    elif [[ "$return_value" -eq "$DIALOG_ESC" ]]; then
        _main_config_dialog
    fi
}


# Scriptmodule functions ############################

function sources_godot-engine() {
    local url="https://github.com/hiulit/RetroPie-Godot-Game-Engine-Emulator/releases/download/v${SCRIPT_VERSION}"

    for version in "${GODOT_VERSIONS[@]}"; do
        if isPlatform "x86"; then
            downloadAndExtract "${url}/godot_${version}_x11_32.zip" "$md_build"
        elif isPlatform "x86_64"; then
            downloadAndExtract "${url}/godot_${version}_x11_64.zip" "$md_build"
        elif isPlatform "aarch64"; then
            downloadAndExtract "${url}/frt_${version}_arm64.zip" "$md_build"
        elif isPlatform "rpi1"; then
            downloadAndExtract "${url}/frt_${version}_pi1.zip" "$md_build"
        elif isPlatform "rpi2" || isPlatform "rpi3" || isPlatform "rpi4"; then
            downloadAndExtract "${url}/frt_${version}_pi2.zip" "$md_build"
        fi
    done
}


function install_godot-engine() {
    if [[ -d "$md_build" ]]; then
        md_ret_files=($(ls "$md_build"))
    else
        echo "ERROR: Can't install '$RP_MODULE_ID'." >&2
        echo "There must have been a problem downloading the sources." >&2
        exit 1
    fi
}

# Parameters:
# - use_frt [flag, gpio/virtual keyboard]
# - force_gles2 [flag]
function configure_godot-engine() {
    local bin_file_tmp
    local bin_files=()
    local bin_files_tmp=()
    local default
    local index
    local version

    mkRomDir "$RP_MODULE_ID"

    # Check if there are parameters.
    if [[ -n "$1" ]]; then
        if [[ "$1" == "use_frt" ]]; then
            FRT_FLAG="$2"
            FRT_KEYBOARD="$3"
        elif [[ "$1" == "force_gles2" ]]; then
            GLES2_FLAG="$2"
        fi
    fi

    if [[ -d "$md_inst" ]]; then
        # Get all the files in the installation folder.
        bin_files_tmp=($(ls "$md_inst"))

        # Remove the extra "retropie.pkg" file and create the final array with the needed files.
        for bin_file_tmp in "${bin_files_tmp[@]}"; do
            if [[ "$bin_file_tmp" != "retropie.pkg" ]]; then
                bin_files+=("$bin_file_tmp")
            fi
        done
    else
        echo "ERROR: Can't configure '$RP_MODULE_ID'." >&2
        echo "There must have been a problem installing the binaries." >&2
        exit 1
    fi

    # Remove the file that contains all the configurations for the different Godot "emulators".
    # It will be created from scratch when adding the emulators in the "addEmulator" functions below.
    [[ -f "/opt/retropie/configs/$RP_MODULE_ID/emulators.cfg" ]] && rm "/opt/retropie/configs/$RP_MODULE_ID/emulators.cfg"

    for index in "${!bin_files[@]}"; do
        default=0
        [[ "$index" -eq "${#bin_files[@]}-1" ]] && default=1 # Default to the last item in "bin_files".
        
        # Get the version from the file name.
        version="${bin_files[$index]}"
        # Cut between "_".
        version="$(echo $version | cut -d'_' -f 2)"

        if isPlatform "x86" || isPlatform "x86_64"; then
            addEmulator "$default" "$md_id-$version" "$rp_module_id" "$md_inst/${bin_files[$index]} --main-pack %ROM%"
        else
            if [[ "$FRT_FLAG" -eq 1 && "$GLES2_FLAG" -eq 1 ]]; then
                addEmulator "$default" "$md_id-$version" "$rp_module_id" "FRT_KEYBOARD_ID='$FRT_KEYBOARD' $md_inst/${bin_files[$index]} --main-pack %ROM% --video-driver GLES2"
            elif [[ "$FRT_FLAG" -eq 1 && "$GLES2_FLAG" -eq 0 ]]; then
                addEmulator "$default" "$md_id-$version" "$rp_module_id" "FRT_KEYBOARD_ID='$FRT_KEYBOARD' $md_inst/${bin_files[$index]} --main-pack %ROM%"
            elif [[ "$FRT_FLAG" -eq 0 && "$GLES2_FLAG" -eq 1 ]]; then
                addEmulator "$default" "$md_id-$version" "$rp_module_id" "$md_inst/${bin_files[$index]} --main-pack %ROM% --video-driver GLES2"
            else
                addEmulator "$default" "$md_id-$version" "$rp_module_id" "$md_inst/${bin_files[$index]} --main-pack %ROM%"
            fi
        fi
    done

    addSystem "$RP_MODULE_ID" "Godot Engine" ".pck .zip"
}

function gui_godot-engine() {
    if isPlatform "x86" || isPlatform "x86_64"; then
        local platform
        if isPlatform "x86"; then
            platform="x86"
        fi
        if isPlatform "x86_64"; then
            platform="x86_64"
        fi
        dialog \
            --backtitle "$DIALOG_BACKTITLE" \
            --title "Info" \
            --ok-label "OK" \
            --msgbox "There are no configuration options for the '$platform' platform.\n\nConfiguration options are only available for single-board computers, such as the Raspberry Pi." \
            10 65 2>&1 >/dev/tty
    else
        local emulators_config_file="/opt/retropie/configs/$RP_MODULE_ID/emulators.cfg"

        if grep "FRT_KEYBOARD_ID" "$emulators_config_file" > /dev/null; then
            FRT_FLAG=1
            # Get the first line of the file.
            line="$(sed -n 1p "$emulators_config_file")"
            # Get the string between single quotes.
            FRT_KEYBOARD="$(echo "$line" | cut -d"'" -f 2)"
        fi

        if grep "GLES2" "$emulators_config_file" > /dev/null; then
            GLES2_FLAG=1
        fi

        _main_config_dialog
    fi
}
