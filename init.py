#!/usr/bin/env python
# -*- coding: utf-8 -*

import sqlite3
import arrow

DBB = sqlite3.connect('../Arduinopinic/db.sqlite3')
cursor = DBB.cursor()
cursor.execute('''INSERT INTO Arduinopinic_config(i2c,delay,timezone,lastmodified,'check') VALUES(36,120,'Europe/Brussels','arrow.utc().format()',0)''')
DBB.commit()
DBB.close()
