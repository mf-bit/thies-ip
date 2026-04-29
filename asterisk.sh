#!/bin/bash

# Where the config should go
asteriskLoc=/etc/asterisk
extensionsDest=$asteriskLoc/extensions.conf
extconfigDest=$asteriskLoc/extconfig.conf
pjsipDest=$asteriskLoc/pjsip.conf
featuresDest=$asteriskLoc/features.conf
modulesDest=$asteriskLoc/modules.conf
sorceryDest=$asteriskLoc/sorcery.conf

# The current working directory
curDir=$(pwd)

# Create symlinks for the actual asterisk content
echo "Creating symlink for $extensionsDest"
ln -sf $curDir/conf/extensions.conf $extensionsDest

echo "Creating symlink for $pjsipDest"
ln -sf $curDir/conf/pjsip.conf $pjsipDest

echo "Creating symlink for $featuresDest"
ln -sf $curDir/conf/features.conf $featuresDest

echo "Creating symlink for $extconfigDest"
ln -sf $curDir/conf/extconfig.conf $extconfigDest

echo "Creating symlink for $modulesDest"
ln -sf $curDir/conf/modules.conf $modulesDest

echo "Creating symlink for $sorceryDest"
ln -sf $curDir/conf/sorcery.conf $sorceryDest





