#!/bin/bash

# ====================================================================
# This scripts checks if the needed tools are available on the machine
# before moving one. It installed them if not present
# Note that we suppose Ubuntu as the underlying distro, as asterisk is .. voila quoi
# ====================================================================

# ====== Checking if we deal with Ubuntu                  ========= 
# ====== Ubuntu means "humanity toward others" by the way ========= 
cat /etc/os-release | grep 'NAME="Ubuntu' &> /dev/null
if (( $? != 0 )); then
  echo "This machine ain't running Ubuntu. This will work only in that distro"
  echo "Exiting..."
  exit
fi

apt update 

# ======= Checking for Asterisk ==============
asterisk -V &> /dev/null                        # Check if it is installed
if (( $? != 0 )); then                          # Install it if not
  echo "-- Asterisk not present, installing..."
  apt -y install asterisk
  if (( $? != 0 ));  then                       # Stop and quit if an error happen during installation: yeah asterisk can be oulalah someties
    exit
  fi
  systemctl enable asterisk
else
  echo "-- Asterisk already installed, skipping installation"
fi


# ======= Checking for GIT ==============
git --version &> /dev/null
if (( $? != 0 )); then                          
  echo "-- Git ain't installed (Seriously? Wait I burn this machine.)"
  echo "-- Installing Git..."
  apt -y install git
fi

# ======= Checking for Python3 and Pip3 ==============
python3 --version &> /dev/null
if (( $? != 0 )); then                          
  echo "-- Python ain't installed (That's clear u ain't lazy, i hope your have C)"
  echo "-- Installing Python..."
  apt -y install python3
fi

pip3 --version &> /dev/null                     # It seems that in some distro, Python3 ain't come with pip3
if (( $? != 0 )); then                          # ... Ubuntu is one of those
  echo "-- Pip3 ain't present, installing..."
  apt -y install python3-pip
fi

# ======= Checking for python-venv ==============
apt list --installed python3-venv | grep "python3-venv" &> /dev/null 
if (( $? != 0 )); then                          
  echo "-- Python3-venv ain't present, installing..."
  apt -y install python3-venv
fi

# ====== Checking for tools needed to interact with a Mysql/MariaBD databases =====
# These are needed to allow asterisk talks to a mysql database
apt install -y unixodbc unixodbc-dev odbc-mariadb