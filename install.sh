#!/bin/bash

# The config in the project, local

# Where the config should go
asteriskLoc=/etc/asterisk
extensionsDest=$asteriskLoc/extensions.conf
pjsipDest=$asteriskLoc/pjsip.conf
featuresDest=$asteriskLoc/features.conf

# Create symlinks for the actual asterisk content
echo "Creating symlink for $extensionsDest"
ln -sf conf/extensions.conf $extensionsDest

echo "Creating symlink for $pjsipDest"
ln -sf conf/pjsip.conf $pjsipDest

echo "Creating symlink for $featuresDest"
ln -sf conf/features.conf $featuresDest

# Warns the user, oh yeah
echo "==========================================="
echo " Do not delete the install repo afterwards, as the config files in /etc/ link"
echo " symbolically to it. It you delte the repo, things will break"
echo "==========================================="
