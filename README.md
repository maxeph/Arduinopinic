# Arduinopinic

Arduinopinic is a front-end which will allow you to manage all your Aquaponic system.

This front-end is based on Django server and designed with Bootstrap 4.

The front-end is communicating with the various sensors through the Arduinopinic daemon which is developed in python. This repository only includes installation script which will clone the various Arduinopinic repositories.

## Installation

```bash
sudo apt-get update -y && sudo apt-get upgrade -y
sudo raspi-config
sudo apt-get install git -y
git clone https://github.com/maxeph/install_Arduinopinic.git
cd install_Arduinopinic/
chmod 777 install.sh
./install.sh
```

## Usage

The installation package will set up two systemd services. To get information about these services, use the following commands:
```bash
systemctl status APC_daemon.service
systemctl status APC_django.service
```

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.
