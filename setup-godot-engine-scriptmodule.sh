#!/usr/bin/env bash
# setup-godot-engine-scriptmodule.sh
#
# RetroPie Godot Engine "Emulator"
# A scriptmodule to install a Godot "emulator" for RetroPie.
#
# Author: hiulit
# Repository: https://github.com/hiulit/RetroPie-Godot-Engine-Emulator
# License: MIT https://github.com/hiulit/RetroPie-Godot-Engine-Emulator/blob/master/LICENSE
#
# Requirements:
# - RetroPie 4.x.x

# Globals ####################################################################

user="$SUDO_USER"
[[ -z "$user" ]] && user="$(id -un)"

home="$(eval echo ~$user)"

readonly RP_DIR="$home/RetroPie"
readonly RP_ROMS_DIR="$RP_DIR/roms"
readonly RP_EMULATORS_DIR="/opt/retropie/emulators"

readonly SCRIPT_VERSION="1.6.0"
readonly SCRIPT_DIR="$(cd "$(dirname $0)" && pwd)"
readonly SCRIPT_NAME="$(basename "$0")"
readonly SCRIPT_FULL="$SCRIPT_DIR/$SCRIPT_NAME"
readonly SCRIPT_TITLE="RetroPie Godot Engine \"Emulator\""
readonly SCRIPT_DESCRIPTION="A scriptmodule to install a Godot \"emulator\" for RetroPie."

readonly SCRIPTMODULE_NAME="godot-engine"
readonly SCRIPTMODULE_FILE="scriptmodules/emulators/$SCRIPTMODULE_NAME.sh"

readonly OVERRIDE_CFG_DEFAULTS_FILE=".override_defaults.cfg"
readonly OVERRIDE_CFG_FILE="override.cfg"


# Variables ##################################################################

RPS_DIR="$home/RetroPie-Setup"


# Functions ##################################################################

function is_retropie() {
    [[ -d "$RP_DIR" && -d "$home/.emulationstation" && -d "/opt/retropie" ]]
}


function usage() {
    echo
    echo "USAGE: $0 [OPTIONS]"
    echo
    echo "Use '$0 --help' to see all the options."
    echo
}


function check_path() {
    if [[ -n "$1" ]]; then
        if [[ -d "$1" ]]; then
            RPS_DIR="$1"
        else
            echo >&2
            echo "ERROR: '$1' doesn't exist!" >&2
            echo >&2
            exit 1
        fi
    fi
}


function install() {
    echo
    echo "> Installing '$SCRIPTMODULE_NAME' scriptmodule (v$SCRIPT_VERSION)..."

    # Install "godot-engine" scriptmodule.
    cat "$SCRIPT_DIR/$SCRIPTMODULE_FILE" > "$RPS_DIR/$SCRIPTMODULE_FILE"

    if [[ "$?" -eq 0 ]]; then
        # Install ".override_defaults.cfg".
        cat "$SCRIPT_DIR/$OVERRIDE_CFG_DEFAULTS_FILE" > "$RP_ROMS_DIR/$SCRIPTMODULE_NAME/$OVERRIDE_CFG_DEFAULTS_FILE"
        if ! [[ "$?" -eq 0 ]]; then
            echo "ERROR: Couldn't install '.override_defaults.cfg'." >&2
            echo >&2
        fi

        # Install "override.cfg".
        cat "$SCRIPT_DIR/$OVERRIDE_CFG_DEFAULTS_FILE" > "$RP_ROMS_DIR/$SCRIPTMODULE_NAME/$OVERRIDE_CFG_FILE"
        if ! [[ "$?" -eq 0 ]]; then
            echo "ERROR: Couldn't install 'override.cfg'." >&2
            echo >&2
        fi

        echo
        echo "'$SCRIPTMODULE_NAME' scriptmodule installed successfully!"
        echo
        echo "Installation"
        echo "------------"
        echo "To install '$SCRIPTMODULE_NAME' emulator, run: 'sudo $RPS_DIR/retropie_setup.sh'."
        echo
        echo "Go to:"
        echo
        echo "|- Manage packages"
        echo "  |- Manage optional packages"
        echo "    |- $SCRIPTMODULE_NAME"
        echo "      |- Install from source"
        echo
        echo "After installation information"
        echo "------------------------------"
        echo "Copy your games to '$RP_ROMS_DIR/$SCRIPTMODULE_NAME'."
        echo "Game extensions: .pck .zip."
        echo
    else
        echo >&2
        echo "ERROR: Couldn't install '$SCRIPTMODULE_NAME' scriptmodule." >&2
        echo >&2
    fi
}


function uninstall() {
    echo
    echo "> Uninstalling '$SCRIPTMODULE_NAME' scriptmodule..."

    if [[ ! -f "$RPS_DIR/$SCRIPTMODULE_FILE" ]]; then
        echo >&2
        echo "ERROR: Can't uninstall '$SCRIPTMODULE_NAME' scriptmodule because it is not installed!" >&2
        echo >&2
        exit 1
    fi

    if [[ -d "$RP_EMULATORS_DIR/$SCRIPTMODULE_NAME" ]]; then
        echo >&2
        echo "ERROR: '$SCRIPTMODULE_NAME' emulator is still installed." >&2
        echo >&2
        echo "To uninstall '$SCRIPTMODULE_NAME' emulator, run: 'sudo $RPS_DIR/retropie_setup.sh'." >&2
        echo >&2
        echo "Go to:" >&2
        echo >&2
        echo "|- Manage packages" >&2
        echo "  |- Manage optional packages" >&2
        echo "    |- $SCRIPTMODULE_NAME" >&2
        echo "      |- Remove" >&2
        echo >&2
        exit 1
    fi

    rm "$RPS_DIR/$SCRIPTMODULE_FILE"

    if [[ "$?" -eq 0 ]]; then
        echo
        echo "'$SCRIPTMODULE_NAME' scriptmodule uninstalled successfully!"
        echo
    else
        echo >&2
        echo "ERROR: Couldn't uninstall '$SCRIPTMODULE_NAME' scriptmodule." >&2
        echo >&2
    fi
}


function update() {
    echo
    echo "> Updating '$SCRIPTMODULE_NAME' scriptmodule..."

    if [[ ! -f "$RPS_DIR/$SCRIPTMODULE_FILE" ]]; then
        echo >&2
        echo "ERROR: Can't update '$SCRIPTMODULE_NAME' scriptmodule because it is not installed!" >&2
        echo >&2
        echo "Run '$0 --install' to install '$SCRIPTMODULE_NAME' scriptmodule." >&2
        echo >&2
        exit 1
    fi

    # Update "godot-engine" scriptmodule.
    cat "$SCRIPT_DIR/$SCRIPTMODULE_FILE" > "$RPS_DIR/$SCRIPTMODULE_FILE"
    
    if [[ "$?" -eq 0 ]]; then
        # Update ".override_defaults.cfg".
        cat "$SCRIPT_DIR/$OVERRIDE_CFG_DEFAULTS_FILE" > "$RP_ROMS_DIR/$SCRIPTMODULE_NAME/$OVERRIDE_CFG_DEFAULTS_FILE"
        if ! [[ "$?" -eq 0 ]]; then
            echo "ERROR: Couldn't update '.override_defaults.cfg'." >&2
            echo >&2
        fi

        # If "override.cfg" doesn't exists, create it.
        if [[ ! -f "$RP_ROMS_DIR/$SCRIPTMODULE_NAME/$OVERRIDE_CFG_FILE" ]]; then
            cat "$SCRIPT_DIR/$OVERRIDE_CFG_DEFAULTS_FILE" > "$RP_ROMS_DIR/$SCRIPTMODULE_NAME/$OVERRIDE_CFG_FILE"
            if ! [[ "$?" -eq 0 ]]; then
                echo "ERROR: Couldn't install 'override.cfg'." >&2
                echo >&2
            fi
        fi

        echo
        echo "'$SCRIPTMODULE_NAME' updated to v$SCRIPT_VERSION successfully!"
        echo
    else
        echo >&2
        echo "ERROR: Couldn't update '$SCRIPTMODULE_NAME'." >&2
        echo >&2
    fi
}


function get_options() {
    if [[ -z "$1" ]]; then
        usage
        exit 0
    else
        case "$1" in
#H -h,  --help              Prints the help message.
            -h|--help)
                echo
                echo "$SCRIPT_TITLE"
                for ((i=1; i<="${#SCRIPT_TITLE}"; i+=1)); do [[ -n "$dashes" ]] && dashes+="-" || dashes="-"; done && echo "$dashes"
                echo "$SCRIPT_DESCRIPTION"
                echo
                echo "USAGE: $0 [OPTIONS]"
                echo
                echo "OPTIONS:"
                echo
                sed '/^#H /!d; s/^#H //' "$0"
                echo
                exit 0
                ;;
#H -v,  --version           Prints the script version.
            -v|--version)
                echo "$SCRIPT_VERSION"
                ;;
#H -i,  --install [path]    Installs "godot-engine" scriptmodule.
#H                              Path: The location of the "RetroPie-Setup" folder.
#H                              Default: "$home/RetroPie-Setup".
            -i|--install)
                check_path "$2"
                install
                ;;
#H -u,  --uninstall [path]  Uninstalls "godot-engine" scriptmodule.
#H                              Path: The location of the "RetroPie-Setup" folder.
#H                              Default: "$home/RetroPie-Setup".
            -u|--uninstall)
                check_path "$2"
                uninstall
                ;;
#H -U, --update [path]     Updates "godot-engine" scriptmodule.
#H                              Path: The location of the "RetroPie-Setup" folder.
#H                              Default: "$home/RetroPie-Setup".
            -U|--update)
                check_path "$2"
                update
                ;;
            *)
                echo >&2
                echo "ERROR: Invalid option '$1'." >&2
                exit 2
                ;;
        esac
    fi
}

function main() {
    if ! is_retropie; then
        echo >&2
        echo "ERROR: RetroPie is not installed. Aborting..." >&2
        exit 1
    fi

    if [[ ! -d "$RPS_DIR" ]]; then
        echo >&2
        echo "ERROR: '$RPS_DIR' doesn't exist." >&2
        echo >&2
        echo "Please, input the location of the 'RetroPie-Setup' folder." >&2
        echo "Example: $0 [OPTION] \"/home/pi/RetroPie-Setup\"" >&2
        exit 1
    fi

    get_options "$@"
}

main "$@"
