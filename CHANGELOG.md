# CHANGELOG

## Unreleased

- Up to date

## [1.10.1] - 2022-05-16

### Added

- `godot-engine` theme for `carbon-2021`.

## [1.10.0] - 2022-05-10

### Added

- New Godot and FRT `3.4.4` binaries.

## [1.9.0] - 2021-11-08

### Added

- New Godot and FRT `3.3.4` and `3.4` binaries.

## [1.8.2] - 2021-06-01

### Added

- A [scraper](https://github.com/hiulit/RetroPie-Itchio-Godot-Scraper) for games hosted on https://itch.io/.

### Changed

- Check for minor version updates to install binaries.

### Fixed

- Issue when installing/updating the settings files.

## [1.8.1] - 2021-05-28

### Changed

- Now `GLES2` is the default video driver.

### Fixed

- Don't add empty values for `FRT_KEYBOARD_ID` and `FRT_KMSDRM_DEVICE`.
- Only show **KMS/DRM driver** dialog menu if `/dev/dri` exists.

## [1.8.0] - 2021-05-27

### Added

- New Godot and FRT `3.3.2` binaries.
- New `godot-engine-settings.cfg` file to store all the settings. Can be changed manually in `~/RetroPie/roms/godot-engine/settings/godot-engine-settings.cfg` or by using the GUI menu via `RetroPie-Setup`.
- New dialog menus to tweak the settings:
    - DRM/KMS driver (FRT only): Select the dri card.
    - Audio driver: Select between `ALSA` (default) and `PulseAudio`.

### Fixed

- Installing/updating the settings files.
- The `godot-engine` system for the default EmulationStation theme is installed automatically and can't be deleted.

## [1.7.0] - 2021-05-20

### Added

- All the FRT binaries can exit the game the same way RetroPie does with the libretro emulators. That is: <kbd>Shift + Enter</kbd> on a keyboard and <kbd>Start + Select</kbd> on a gamepad.
- Fullscreen support.
- Configuration options for the `x86` and `x86_64` platforms.
- New dialog menu to install themes for the `godot-engine` system.

### Changed

- Optimized the UX of the dialog menus.

## [1.6.0] - 2021-05-13

### Added

- Updated Godot `3.2.3` binaries to `3.3`.
- Updated FRT binaries to [v1.0.0](https://github.com/efornara/frt/releases/tag/1.0.0).

## [1.5.1] - 2021-03-23

### Fixed

- There was an issue when updating the scriptmodule.

## [1.5.0] - 2021-03-23

### Added

- A new `override.cfg` file in `~/RetroPie/roms/godot-engine`, with some default audio values, to let the user [override settings](https://docs.godotengine.org/de/stable/classes/class_projectsettings.html) of the Godot "emulator".
- New documentation about audio issues (see [#7](https://github.com/hiulit/RetroPie-Godot-Engine-Emulator/issues/7)).

### Changed

- New Pixel theme's Godot logo.

### Fixed

- Godot `2.1.6` command line options [#4](https://github.com/hiulit/RetroPie-Godot-Engine-Emulator/issues/4).

## [1.4.0] - 2021-03-17

### Added

- Godot `x86_64` binaries.

### Changed

- Abbreviation for `--update` is now `-U`.
- Use RetroPie's helper functions instead of using our own.
- Binaries are now distributed in a zip file.

### Fixed

- Configuration dialog back button was exiting instead of going back.

### Removed

- Godot binaries compiled for the Raspberry Pi 4. RetroPie doesn't use X11 so they were useless :)

## [1.3.1] - 2020-12-03

### Added

- New Godot binaries compiled for the Raspberry Pi 4 (`godot-engine-2.1.6-rpi4`).

### Fixed

- An [audio issue](https://github.com/godotengine/godot/pull/43928) affecting the Raspberry Pi 4. All FRT and Godot "emulators" for the Raspberry Pi 4 have been updated with that fix.

### Changed

- Updated FRT binaries to [v0.9.9a](https://github.com/efornara/frt/releases/tag/0.9.9a).

## [1.3.0] - 2020-11-23

### Added

- Support for the Raspberry Pi 4.
- New Godot binaries compiled specifically for the Raspberry Pi 4 (`godot-engine-x.x.x-rpi4`).
- A new option in the scriptmodule's configuration menu to force Godot to use the GLES2 video driver on single-board computers, such as the Raspberry Pi.
- A [compatibility list](https://docs.google.com/spreadsheets/d/1ybU_NHqhnJmZnlP9YDDGEf4BJ5nInbfsVVQtQCM7rYw/edit?usp=sharing) to check which games work.

### Changed

- Updated FRT binaries to [v0.9.8](https://github.com/efornara/frt/releases/tag/0.9.8).
- Updated Godot versions (`3.2.3`).

## [1.2.3] - 2020-02-04

### Changed

- Updated FRT binaries to [v0.9.7](https://github.com/efornara/frt/releases/tag/0.9.7).
- Updated Godot versions (`2.1.6`, `3.0.6`, `3.1.2` and `3.2.0`).

## [1.2.2] - 2019-11-08 

### Added

- Remove `emulators.cfg` before creating a new one.
- New documentation on how to properly install the script.

## [1.2.1] - 2019-11-08

### Changed

- Removed bin files from the repository. The bin files are now in its own [release](https://github.com/hiulit/RetroPie-Godot-Game-Engine-Emulator/releases).
- Now the scriptmodule's download url is connected to the script's version.

### Deprecated

- Don't use versions prior to **v1.2.0**. The download url won't work.

## [1.2.0] - 2019-11-08

### Added

- Support for GPIO/Virtual keyboards for single board computers, such as the Raspberry Pi.
- Licenses for Godot and FRT.

### Changed

- Now the scriptmodule only downloads the binaries needed for a particular platform instead of cloning the whole repository, thus downloading all the binaries.

## [1.1.0] - 2019-10-25

- Updated FRT binaries to [v0.9.6](https://github.com/efornara/frt/releases/tag/0.9.6).

## [1.0.0] - 2019-08-21

- Released stable version.
