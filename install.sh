#!/bin/bash

############# Get install dir into variable
MY_PATH="`dirname \"$0\"`"
MY_PATH="`( cd \"$MY_PATH\" && pwd )`"
if [ -z "$MY_PATH" ] ; then
  # error; for some reason, the path is not accessible
  # to the script (e.g. permissions re-evaled after suid)
  exit 1  # fail
fi

cd $PATH
cd ..
INSTALL_PATH=$PWD
DJANGO_PATH=${PWD}/Arduinopinic
DAEMON_PATH=${PWD}/Arduinopinic/Arduinopinic/daemon
cd install_Arduinopinic
#########

############# Updating service files
sed -i "s/REPOCHEMIN/${DJANGO_PATH//\//\\/}/g" module/APC_daemon.service
sed -i "s/DAEMONCHEMIN/${DAEMON_PATH//\//\\/}/g" module/APC_daemon.service
sed -i "s/REPOCHEMIN/${DJANGO_PATH//\//\\/}/g" module/APC_django.service

#########

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

echo -e "\n\033[32m######## creating services ########\033[0m"
sudo cp module/APC_daemon.service /etc/systemd/system/APC_daemon.service
sudo cp module/APC_django.service /etc/systemd/system/APC_django.service
sudo systemctl enable APC_daemon.service
sudo systemctl enable APC_django.service
sudo systemctl start APC_daemon.service
sudo systemctl start APC_django.service

echo "Services implemented..."

mkdir ../Arduinopinic/Arduinopinic/daemon/log
