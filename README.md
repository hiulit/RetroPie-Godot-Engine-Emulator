# RetroPie Godot Game Engine "Emulator"

A Godot "emulator" for RetroPie.

## Installation

```
cd /home/pi/
git clone https://github.com/hiulit/RetroPie-Godot-Game-Engine-Emulator.git
cd RetroPie-Godot-Game-Engine-Emulator/
sudo chmod +x install-godot-engine.sh
./install-godot-engine.sh
```

The installation script assumes that you are running it on a Raspberry Pi with the `RetroPie-Setup` folder being stored in `/home/pi/RetroPie-Setup `. If your setup differs, you can pass the path where your `RetroPie-Setup` folder is stored as a parameter, like this:


```
./install-godot-engine.sh "/path/to/your/RetroPie-Setup"
```

## Updating

```
cd /home/pi/RetroPie-Godot-Game-Engine-Emulator/
git pull
./install-godot-engine.sh
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