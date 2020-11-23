# CHANGELOG

## Unreleased

* Up to date

## [1.3.0] - 2020-11-23

### Added

* Support for the Raspberry Pi 4.
* New Godot binaries compiled specifically for the Raspberry Pi 4 (`godot-engine-x.x.x-rpi4`).
* A new option in the scriptmodule's configuration menu to force Godot to use the GLES2 video driver on single-board computers, such as the Raspberry Pi.
* A [compatibility list](https://docs.google.com/spreadsheets/d/1ybU_NHqhnJmZnlP9YDDGEf4BJ5nInbfsVVQtQCM7rYw/edit?usp=sharing) to check which games work.

### Changed

* Updated FRT binaries to [v0.9.8](https://github.com/efornara/frt/releases/tag/0.9.8).
* Updated Godot versions (`3.2.3`).

## [1.2.3] - 2020-02-04

### Changed

* Updated FRT binaries to [v0.9.7](https://github.com/efornara/frt/releases/tag/0.9.7).
* Updated Godot versions (`2.1.6`, `3.0.6`, `3.1.2` and `3.2.0`).

## [1.2.2] - 2019-11-08

### Added

* Remove `emulators.cfg` before creating a new one.
* New documentation on how to properly install the script.

## [1.2.1] - 2019-11-08

### Changed

* Removed bin files from the repository. The bin files are now in its own [release](https://github.com/hiulit/RetroPie-Godot-Game-Engine-Emulator/releases).
* Now the scriptmodule's download url is connected to the script's version.

### Deprecated

* Don't use versions prior to **v1.2.0**. The download url won't work.

## [1.2.0] - 2019-11-08

### Added

* Support for GPIO/Virtual keyboards for single board computers, such as the Raspberry Pi.
* Licenses for Godot and FRT.

### Changed

*  Now the scriptmodule only downloads the binaries needed for a particular platform instead of cloning the whole repository, thus downloading all the binaries.

## [1.1.0] - 2019-10-25

* Updated FRT binaries to [v0.9.6](https://github.com/efornara/frt/releases/tag/0.9.6).

## [1.0.0] - 2019-08-21

* Released stable version.
