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

## Installation

```
cd /home/pi/
./install-godot-engine-scriptmodule.sh
```

## Uninstall

```
cd /home/pi/
./uninstall-godot-engine-scriptmodule.sh
```

## Updating

```
cd /home/pi/
./update-godot-engine-scriptmodule.sh
```

The scripts assume that you are running it on a Raspberry Pi with the `RetroPie-Setup` folder being stored in `/home/pi/RetroPie-Setup`. If your setup differs, you can pass the path where your `RetroPie-Setup` folder is stored as a parameter, like this:


```
./install-godot-engine-scriptmodule.sh "/path/to/your/RetroPie-Setup"
./uninstall-godot-engine-scriptmodule.sh "/path/to/your/RetroPie-Setup"
./update-godot-engine-scriptmodule.sh "/path/to/your/RetroPie-Setup"
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
