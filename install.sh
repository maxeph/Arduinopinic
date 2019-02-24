#!/bin/bash

echo -e "\n\033[32m######## installing virtualenv ########\033[0m"
sudo apt-get install virtualenv -y

echo -e "\n\033[32m######## cloning repositories ########\033[0m"
git clone https://github.com/maxeph/frontend_Arduinopinic.git ../Arduinopinic
git clone https://github.com/maxeph/daemon_Arduinopinic.git ../Arduinopinic/Arduinopinic/daemon

echo -e "\n\033[32m######## creating virtualenv ########\033[0m"
virtualenv ../Arduinopinic/.venv/venvArduinopinic && source ../Arduinopinic/.venv/venvArduinopinic/bin/activate

echo -e "\n\033[32m######## installing dependencies ########\033[0m"
pip install django crcmod arrow smbus2 terminaltables docopt

echo -e "\n\033[32m######## changing rights on executables ########\033[0m"
chmod 777 ../Arduinopinic/manage.py
chmod 777 ../Arduinopinic/Arduinopinic/daemon/daemon.py
echo "Rights granted to Arduinopinic executables..."

echo -e "\n\033[32m######## creating database ########\033[0m"
python ../Arduinopinic/manage.py makemigrations
python ../Arduinopinic/manage.py migrate
python module/database.py

mkdir ../Arduinopinic/Arduinopinic/daemon/log
