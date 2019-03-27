#!/usr/bin/env bash
# uninstall-godot-engine-scriptmodule.sh
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

readonly SCRIPT_NAME="$(basename "$0")"

RPS_DIR="$home/RetroPie-Setup"

if [[ -n "$1" ]]; then
	RPS_DIR="$1"
fi

if [[ ! -d "$RPS_DIR" ]]; then
	echo "ERROR: '$RPS_DIR' diretory doesn't exist." >&2
	echo
	echo "Please, input the location of the 'RetroPie-Setup' folder." >&2
	echo "Example: ./$SCRIPT_NAME \"/home/pi/RetroPie-Setup\"" >&2
	exit 1
fi

echo "Uninstalling 'godot-engine.sh' scriptmodule ..."

rm "$RPS_DIR/scriptmodules/emulators/godot-engine.sh"
return_value="$?"
if [[ "$return_value" -eq 0 ]]; then
	echo "'godot-engine.sh' scriptmodule uninstalled successfully!"
else
	echo "ERROR: Couldn't uninstall 'godot-engine.sh' scriptmodule." >&2
fi
