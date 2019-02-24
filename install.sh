#!/bin/bash
sudo apt-get install virtualenv -y
git clone https://github.com/maxeph/frontend_Arduinopinic.git
git clone https://github.com/maxeph/frontend_Arduinopinic.git frontend_Arduinopinic/daemon
chmod 777 frontend_Arduinopinic/manage.py
virtualenv venvArduinopinic && source venvArduinopinic/bin/activate
pip install django crcmod arrow smbus2 terminaltables docopt
python frontend_Arduinopinic/manage.py migrate
python frontend_Arduinopinic/manage.py makemigrations
chmod 777 frontend_Arduinopinic/daemon/piserver.py
