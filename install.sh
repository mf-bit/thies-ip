#!/bin/bash

# ================================================
# Initialize the machine for asteriks
# ================================================

# -- Check if the machine is ready for asterisk
source scripts/check.sh

# -- Prepare asterisk to use a remote database
source scripts/db.sh

# -- Handle asterisk config files
confDir="./conf" source scripts/conf.sh
