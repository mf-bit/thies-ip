#!/bin/bash

# ================================================
# Edit the config files in /etc/asterisk 
# ================================================

# Where the config should go
asteriskLoc=/etc/asterisk
extensionsDest=$asteriskLoc/extensions.conf
extconfigDest=$asteriskLoc/extconfig.conf
pjsipDest=$asteriskLoc/pjsip.conf
featuresDest=$asteriskLoc/features.conf
modulesDest=$asteriskLoc/modules.conf
sorceryDest=$asteriskLoc/sorcery.conf

# Create symlinks for the actual asterisk content
echo "Creating symlink for $extensionsDest"
ln -sf $confDir/conf/extensions.conf $extensionsDest

echo "Creating symlink for $pjsipDest"
ln -sf $confDir/conf/pjsip.conf $pjsipDest

echo "Creating symlink for $featuresDest"
ln -sf $confDir/conf/features.conf $featuresDest

echo "Creating symlink for $extconfigDest"
ln -sf $confDir/conf/extconfig.conf $extconfigDest

echo "Creating symlink for $modulesDest"
ln -sf $confDir/conf/modules.conf $modulesDest

echo "Creating symlink for $sorceryDest"
ln -sf $confDir/conf/sorcery.conf $sorceryDest

