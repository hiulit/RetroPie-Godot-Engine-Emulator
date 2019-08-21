# RetroPie Godot Game Engine "Emulator"

A scriptmodule to install a Godot "emulator" for RetroPie.

Thanks to [@efornara](https://github.com/efornara) (for creating [FRT - A Godot "platform" targeting single board computers](https://github.com/efornara/frt)) you can now **play\*** games made with [Godot](https://godotengine.org/) on your Raspberry Pi (and other single board computers) using [RetroPie](https://retropie.org.uk/).

If you are running RetroPie on an `x86` PC, the Godot "emulator" uses the **Linux/X11-32bits** export template instead of **FRT**, so most games should work fine.

There are plenty of games made with Godot, most of them hosted on https://itch.io/.
You can find Godot games using the following links:

* https://itch.io/games/made-with-godot
* https://itch.io/games/tag-godot

**\*Games that (would) work on a Raspberry Pi must have been created with Godot 3.1 using GLES2 (or maybe Godot 2.x) and not using any 'fancy VFX' like particles and other CPU/GPU demanding stuff.**

## Install the setup script

```
cd /home/pi/
curl "https://raw.githubusercontent.com/hiulit/RetroPie-Godot-Game-Engine-Emulator/master/setup-godot-engine-scriptmodule.sh" -o "setup-godot-engine-scriptmodule.sh"
sudo chmod +x setup-godot-engine-scriptmodule.sh
```

## Update the setup script

Same as [Install the script](#install-the-script).

## Usage

```
./setup-godot-engine-scriptmodule.sh [OPTIONS]
```

If no options are passed, you will be prompted with a usage example:

```
USAGE: ./setup-godot-engine-scriptmodule.sh [OPTIONS]

Use '--help' to see all the options.
```

The script assumes that you are running it on a Raspberry Pi with the `RetroPie-Setup` folder being stored in `/home/pi/RetroPie-Setup`. If your setup differs, you can pass the path where your `RetroPie-Setup` folder is stored as a parameter, like this:

```
./setup-godot-engine-scriptmodule.sh [OPTION] "/path/to/your/RetroPie-Setup"
```
## Options

* `--help`: Print the help message and exit.
* `--install`: Install the scriptmodule.
* `--uninstall`: UnInstall the scriptmodule.
* `--update`: Update the scriptmodule.
* `--version`: Show script version.

## Examples

### `--help`

Print the help message and exit.

#### Example

`./setup-godot-engine-scriptmodule.sh --help`

### `--install`

Install the scriptmodule.

#### Example

`./setup-godot-engine-scriptmodule.sh --install`

### `--uninstall`

UnInstall the scriptmodule.

#### Example

`./setup-godot-engine-scriptmodule.sh --uninstall`

### `--update`

Update the scriptmodule.

#### Example

`./setup-godot-engine-scriptmodule.sh --update`

### `--version`

Show script version.

#### Example

`./setup-godot-engine-scriptmodule.sh --version`

## Install the Godot "emulator" from RetroPie-Setup

Once you've [successfully installed](#--install) the scriptmodule, run:

```
sudo /home/pi/RetroPie-Setup/retropie_setup.sh
```

and then go to:

* Manage packages
* Manage optional packages
* godot-engine
* Install from source

A new `godot-engine` folder will be created in `/home/pi/RetroPie/roms/`, where you can put your games using `.pck` and `zip` extensions.

The script installs different versions of the "emulator" for maximum compatibility:

- `2.1.6`
- `3.0.6`
- `3.1.0`
- `3.1.1`

If the game you are trying to play doesn't work, try changing the "emulator" in the [runcommand](https://github.com/RetroPie/RetroPie-Setup/wiki/runcommand).

If you are using an `x86` PC, the "emulators" used are Godot's export templates downloaded from https://godotengine.org/download/.

For the Raspberry Pi, the script will auto-detect if you are using a `0/1` or a `2/3` version and it will install the proper **FRT** "emulators". Same for any `arm64` single computer board.

In case none of the "emulators" work... Sorry.

## Uninstall the Godot "emulator" from RetroPie-Setup

Run:

```
sudo /home/pi/RetroPie-Setup/retropie_setup.sh
```

and then go to:

* Manage packages
* Manage optional packages
* godot-engine
* Remove

## Update the Godot "emulator" from RetroPie-Setup

Run:

```
sudo /home/pi/RetroPie-Setup/retropie_setup.sh
```

and then go to:

* Manage packages
* Manage optional packages
* godot-engine
* Update from source
 
## How to create a new Godot system for an EmulationStation theme

As there is no way to create a script to automate this, because themes don't have the same structure, the best way is to manually create a new system in your preferred theme.

* [Download](https://raw.githubusercontent.com/hiulit/RetroPie-Godot-Game-Engine-Emulator/master/art/system.svg) the Godot `system.svg`.
* [Download](https://raw.githubusercontent.com/hiulit/RetroPie-Godot-Game-Engine-Emulator/master/art/controller.svg) the Godot `controller.svg`.
* Copy any system folder in your theme (e.g. `/etc/emulationstation/themes/[THEME]/nes`).
* Rename it as `godot-engine`.
* Move the Godot `system.svg` and `controller.svg` to the `godot-engine/art` folder.

**Note**

The folder structure in the theme you are using might differ. Take a look at how this particular theme works to create the `godot-engine` folder accordingly. You might need to delete extra icons that are not needed.

## Premade Godot systems

I've created Godot systems for the default EmulationStation theme that comes in RetroPie, **Carbon theme**, and for my personal favourite theme, **Pixel theme**.

Copy the `theme/[THEME]/godot-engine` folder from this repository to `/etc/emulationstation/themes/[THEME]`.

### Carbon theme

![Godot system for EmulationStation's Carbon theme](/example-images/godot-engine-carbon-theme.jpg)

### Pixel theme

![Godot system for EmulationStation's Pixel theme](/example-images/godot-engine-pixel-theme.jpg)

## Changelog

See [CHANGELOG](/CHANGELOG.md).

## Authors

Me 😛 [@hiulit](https://github.com/hiulit).

## Credits

Thanks to:

- Emanuele Fornara [@efornara](https://github.com/efornara) - For creating [FRT - A Godot "platform" targeting single board computers](https://github.com/efornara/frt).
- Andrea Calabró - For creating the **Godot logo**. Changes made to it:
  - Created an outline version.
- Alícia Folgarona Ribot (Alfórium Studios) [@alforiumstudios](https://twitter.com/alforiumstudios) - For creating the **Pixel Godot logo**. Changes made to it:
  - New colors.
  - Added white outline.

## LICENSE

- Source code: [MIT License](/LICENSE).
- Godot logo: [CC BY](https://creativecommons.org/licenses/by/3.0/).
- Pixel Godot logo: [CC BY-NC-SA](https://creativecommons.org/licenses/by-nc-sa/4.0/).
