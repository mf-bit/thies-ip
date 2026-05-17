#!/bin/bash

# ====================================================================
# Prepare the machine to allows asterisk to communicate with a remote
# database. Asterisk will use it to store data instead of using its
# internal database.
#
# ⚠️ Note that this scripts suppose the database already exits and is 
#     ready to be used
# ====================================================================

db_user=asterisk_server
db_pass=makachy-matay
db_ip=192.168.1.34
db_name=asterisk

# -- Since asteriks was installed using `apt`, we need some stuff from its repo that is not present
(
  echo "-- Cloning the Asterisk repo in /usr/src"
  cd /usr/src
  git clone --depth=1 https://github.com/asterisk/asterisk.git
)

# -- Alembic is the tool that will create the asterisk tables
(                                              
  echo "-- Creating a python venv named for-asterisk"
  python3 -m venv for-asterisk
  source for-asterisk/bin/activate
  
  echo "-- Instaling Alembic using pip3 in the venv for-asterisk"
  pip3 install alembic pymysql cryptography

  # -- Handle a little bit of configurations
  cd /usr/src/asterisk/contrib/ast-db-manage
  cp config.ini.sample config.ini
  target="sqlalchemy.url = mysql://user:pass@localhost/asterisk"
  replacement="sqlalchemy.url = mysql+pymysql://$db_user:$db_pass@$db_ip/$db_name"
  command="s|^$target\$|$replacement|"                                                      # | is used as a delimiter for the sed command
  sed -i "$command" config.ini

  # -- Create the table asterisk will rely one using Alembic
  echo "-- Generate asterisk database table using alembic"
  alembic -c config.ini upgrade head
  if (( $? != 0 )); then exit; fi
)

# -- Now we need to handle some config files for the database
echo "-- Handling /etc/odbcinst.ini"
cat <<EOF > /etc/odbcinst.ini
[MariaDB]
Description = MariaDB Connector/ODBC
Driver      = $(find /usr/lib -name "libmaodbc.so" 2>/dev/null)
UsageCount  = 1
EOF

echo "-- Handling /etc/odbc.ini"
cat <<EOF > /etc/odbc.ini
[asterisk]
Description = MariaDB connection to asterisk database
Driver      = MariaDB
Database    = $db_name
Server      = $db_ip
Port        = 3306
UID         = $db_user 
PWD         = $db_pass
Socket      = /var/run/mysqld/mysqld.sock
EOF

# -- Now we need to handle some config files for asterisk to tell it where the db is
echo "-- Handling /etc/asterisk/res_odbc.conf"
cat <<EOF > /etc/asterisk/res_odbc.conf
[asterisk]
enabled     => yes
dsn         => $db_name
username    => $db_user 
password    => $db_pass
pre-connect => yes
EOF

# -- We need a table to store the messages in
message_table=sms_messages
# ===== Add this for message into the database
# CREATE TABLE `sms_messages` (
#   `id` INT AUTO_INCREMENT PRIMARY KEY,
#   `msg_time` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
#   `sender` VARCHAR(50),
#   `receiver` VARCHAR(50),
#   `body` TEXT,
#   `status` VARCHAR(20) DEFAULT 'received'
# ) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

echo "--Handling func_odbc.conf"
cat <<EOF > /etc/asterisk/func_odbc.conf
[INSERT_SMS]
dsn=$db_name
writesql=INSERT INTO $message_table (sender, receiver, body) VALUES ('${SQL_ESC(${VAL1})}', '${SQL_ESC(${VAL2})}', '${SQL_ESC(${VAL3})}')
EOF


