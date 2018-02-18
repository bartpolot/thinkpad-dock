# thinkpad-dock

Small utility to handle docking and undocking of ThinkPad laptops running Linux. Tested with an x200s running Arch and an original Lenovo docking station hooked to a VGA FullHD monitor. 

## Getting Started

These instructions will get you a copy of the project up and running on your local machine. It is heavily reliant on my personal setup so you might need to adapt paths and names for your environment.

### Prerequisites

What things you need to install the software and how to install them:

* ThinkPad laptop
* Docking station
* Monitor
* Linux distro
* `xrandr` installed
* `udev` installed

### Installing

Run the included scrit to install the utility

```
./install.sh
```

It will install two components with sudo, for which you will be asked for your password:

* udev rule to `/etc/udev/rules.d/`

* Global script to `/usr/local/sbin`

And two components for your user, under `~/.config/dock/` and `~/local/bin/`. It assumes that `~/local/bin` is in your path. If not, adapt the install script according to your setup.

## Inner workings

The utility is composed of 4 parts: udev rules, a global script, trigger scripts and user scripts

### udev rules

The udev rules simply call the global script every time the `dock` kernel component changes

### Global script

The global `/usr/local/sbin/thinkpad-dock.sh` script checks the docks status and calls the trigger scripts for any logged-in user.

### Trigger scripts

The trigger scripts live under `~/.config/dock/[on|off]`. They perform some basic checks to make sure the docking process is finished before calling the user scripts

### User scripts

The user scripts should be called `dock` and `undock` and be callable from the shell. This allows call them manually, for instance after boot while docked does not call the udev rule.

The default behavior of the scripts is to turn the VGA output on/off and ajust the conky configuration file according to the docking status.

## License

This project is licensed under GPL - see the [LICENSE](LICENSE) file for details
If you think it should be under some other license, let me know, I don't have strong feelings about any of it, GPL just seems like a safe default.

## Acknowledgments

* Based on code and information found online, too long ago to remember.
* Stackoverflow
