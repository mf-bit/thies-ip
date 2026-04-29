#!/bin/bash

# Handle the asterisk configuration
chmod +x asterisk.sh
./asterisk.sh

# Hnadle the mysql configuration (drivers, etc)
chmod +x mysql.sh
./mysql.sh


# Warns the user, oh yeah
echo "==========================================="
echo " Do not delete the install repo afterwards, as the config files in /etc/ link"
echo " symbolically to it. It you delte the repo, things will break"
echo "==========================================="
