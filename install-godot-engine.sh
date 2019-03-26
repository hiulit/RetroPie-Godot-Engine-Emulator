#!/usr/bin/env bash
# install.sh
#
# RetroPie Godot Game Engine "Emulator"
# A Godot "emulator" for RetroPie.
#
# Author: hiulit
# Repository: https://github.com/hiulit/RetroPie-Godot-Game-Engine-Emulator
# License: MIT https://github.com/hiulit/RetroPie-Godot-Game-Engine-Emulator/blob/master/LICENSE
#
# Requirements:
# - RetroPie 4.x.x

user="$SUDO_USER"
[[ -z "$user" ]] && user="$(id -un)"

home="$(eval echo ~$user)"

readonly SCRIPT_VERSION="1.0.0"
readonly SCRIPT_NAME="$(basename "$0")"
readonly RP_DIR="$home/RetroPie"
readonly RP_ROMS_DIR="$RP_DIR/roms"
RPS_DIR="$home/RetroPie-Setup"

if [[ -n "$1" ]]; then
	RPS_DIR="$1"
fi

if [[ ! -d "$RPS_DIR" ]]; then
	echo "ERROR: '$RPS_DIR' diretory doesn't exist." >&2
	echo
	echo "Please, input the location of the 'RetroPie-Setup' folder."
	echo "Example: ./$SCRIPT_NAME \"/home/pi/RetroPie-Setup\"" >&2
	exit 1
fi

echo "Installing 'godot' scriptmodule ..."
cp -R "scriptmodules/emulators/godot-engine.sh" "$RPS_DIR/scriptmodules/emulators"
return_value="$?"
if [[ "$return_value" -eq 0 ]]; then
	echo "'godot' scriptmodule installed successfully!"
	echo
	echo "Installation"
	echo "------------"
	echo "To install 'godot' run 'sudo $RPS_DIR/retropie_setup.sh'."
	echo
	echo "Go to:"
	echo
	echo "|- Manage packages"
	echo "  |- Manage optional packages"
	echo "    |- godot"
	echo "      |- Install from source"
	echo
	echo "After installation information"
	echo "------------------------------"
	echo "Copy your Godot games to '$RP_ROMS_DIR/godot'."
	echo "Godot game extensions: .pck .zip."
else
	echo "ERROR: Couldn't install 'godot' scriptmodule." >&2
fi
