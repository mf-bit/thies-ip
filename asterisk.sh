#!/bin/bash

# Where the config should go
asteriskLoc=/etc/asterisk
extensionsDest=$asteriskLoc/extensions.conf
pjsipDest=$asteriskLoc/pjsip.conf
featuresDest=$asteriskLoc/features.conf

# The current working directory
curDir=$(pwd)

# Create symlinks for the actual asterisk content
echo "Creating symlink for $extensionsDest"
ln -sf $curDir/conf/extensions.conf $extensionsDest

echo "Creating symlink for $pjsipDest"
ln -sf $curDir/conf/pjsip.conf $pjsipDest

echo "Creating symlink for $featuresDest"
ln -sf $curDir/conf/features.conf $featuresDest


