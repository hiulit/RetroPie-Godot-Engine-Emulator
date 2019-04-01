# RetroPie Godot Game Engine "Emulator"

A Godot "emulator" for RetroPie.

## Setup

```
cd /home/pi/
wget "https://raw.githubusercontent.com/hiulit/RetroPie-Godot-Game-Engine-Emulator/master/install-godot-engine-scriptmodule.sh"
wget "https://raw.githubusercontent.com/hiulit/RetroPie-Godot-Game-Engine-Emulator/master/uninstall-godot-engine-scriptmodule.sh"
wget "https://raw.githubusercontent.com/hiulit/RetroPie-Godot-Game-Engine-Emulator/master/update-godot-engine-scriptmodule.sh"
sudo chmod +x install-godot-engine-scriptmodule.sh
sudo chmod +x uninstall-godot-engine-scriptmodule.sh
sudo chmod +x update-godot-engine-scriptmodule.sh
```

## Install the scriptmodule

```
cd /home/pi/
./install-godot-engine-scriptmodule.sh
```

## Uninstall the scriptmodule

```
cd /home/pi/
./uninstall-godot-engine-scriptmodule.sh
```

## Update the scriptmodule

```
cd /home/pi/
./update-godot-engine-scriptmodule.sh
```

These scripts assume that you are running them on a Raspberry Pi with the `RetroPie-Setup` folder being stored in `/home/pi/RetroPie-Setup`. If your setup differs, you can pass the path where your `RetroPie-Setup` folder is stored as a parameter, like this:


```
./install-godot-engine-scriptmodule.sh "/path/to/your/RetroPie-Setup"
./uninstall-godot-engine-scriptmodule.sh "/path/to/your/RetroPie-Setup"
./update-godot-engine-scriptmodule.sh "/path/to/your/RetroPie-Setup"
```

## How to create a new system for Godot

As there is no way to create a script to automate this, because themes don't have the same structure,the best way is to manually create a new system in your preferred theme.

* [Download](https://raw.githubusercontent.com/hiulit/RetroPie-Godot-Game-Engine-Emulator/master/system.svg) the Godot logo.
* Copy any system folder in your theme (e.g. `/etc/emulationstation/themes/[THEME]/nes`).
* Rename it as `godot-engine`.
* Move the Godot logo in the `godot-engine/art` folder.

**Note**

The folder structure in the theme you are using might differ. Take a look at how this particular theme works to create the `godot-engine` folder accordingly. You might need to delete extra icons that are not needed.

## Example using the default Carbon theme

```
cd /home/pi/
wget "https://raw.githubusercontent.com/hiulit/RetroPie-Godot-Game-Engine-Emulator/master/system.svg"
sudo cp -R "/etc/emulationstation/themes/carbon/nes" "/etc/emulationstation/themes/carbon/godot-engine"
sudo mv "/home/pi/system.svg" "/etc/emulationstation/themes/carbon/godot-engine/art"
```

## Changelog

See [CHANGELOG](/CHANGELOG.md).

## Authors

Me 😛 [@hiulit](https://github.com/hiulit).


## Credits

Thanks to:

- Emanuele Fornara [@efornara](https://github.com/efornara) - For creating [FRT - A Godot "platform" targeting single board computers](https://github.com/efornara/frt).

## LICENSE

[MIT License](/LICENSE).
