#!/bin/bash

db=asteriskDB
username=root
password=root

# We need to find where the driver is installed first
mysqlDriverLoc=$(find /usr/lib -name "libmaodbc.so")

printf "\
[MySQL]
Description = MariaDB ODBC driver (works with MySQL)
Driver      = $mysqlDriverLoc
UsageCount  = 1
" > /etc/odbcinst.ini

printf "\
[asterisk-connector]
Description = MySQL connection to Asterisk
Driver      = MySQL
Database    = $db
Server      = localhost
User        = $username
Password    = $password
Port        = 3306
Option      = 3
"  > /etc/odbc.ini

printf "\
[asterisk]
enabled => yes
dsn => asterisk-connector
username => $username
password => $password
pre-connect => yes
max_connections => 5
" >> /etc/asterisk/res_odbc.conf