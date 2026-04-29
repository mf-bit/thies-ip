#!/bin/bash

# The config in the project, local

# Where the config should go
asterisk=/etc/asterisk
extensionsDest=$asteriskLoc/extensions.conf
pjsipDest=$asteriskLoc/pjsip.conf
featuresDest=$asteriskLoc/features.conf

# Create symlinks for the actual asterisk content
ln -sf conf/extensions.conf $extensionsDest
ln -sf conf/pjsip.conf $pjsipDest
ln -sf conf/features.conf $featuresDest
