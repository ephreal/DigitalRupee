#!/bin/bash
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.
#
# This script was created by Ephreal.
# Copyright 2018
#
# It is Licensed under the GNU GPLv3 which 
# can be found here: https://www.gnu.org/licenses/gpl-3.0.en.html
# If you wish to use this code in any form, please give me credit
# for the code.
#
# Improvements on the code are welcome.
# To contact me, please email contact@mylifeneeds.management
#
#
# Note: This must currently be ran as root to
# work properly. I don't like that. I'm not
# going to change that right now.
#
# Note addendum: This has only been tested and works on Ubuntu. 
#                Not, unfortunately, archlinux.
#
# Version: 1.0
# Release date: June 19, 2018 (2018-06-19)
#

#########################
# Variable Declarations #
#########################

# Directory script is being ran from
SC_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# This is where you want to store your masternode data dirs
MasternodeDataDir=$HOME/Masternodes

# What do you want to call your masternode data directories
MasternodeDirName=Masternode

# A random RPC username
# (Create your own!)
rpcuser=`cat settings.txt | grep rpcuser | cut -d "=" -f2`

# A random RPC password
# (Create your own!)
rpcpassword=`cat settings.txt | grep rpcpassword | cut -d "=" -f2`

# Your server IP address
ServerIP=`cat settings.txt | grep server_ip | cut -d "=" -f2`

# Masternode Private Keys file
keys=$SC_DIR/`cat settings.txt | grep private_key_file | cut -d "=" -f2`

# Only change this if you're doing
# some different setup.
StartingNode=1

# This is the masternode you are 
# setting up (Specified in settings.txt)
EndingNode=`cat settings.txt | grep amount_of_masternodes | cut -d "=" -f2`

# Set this to your starting port
# (Probably 8517)
z=8517

##################
# Update process #
##################

apt-get update && apt-get -y upgrade
apt-get -y install git build-essential libssl-dev libdb++-dev libboost-all-dev libcrypto++-dev libqrencode-dev libminiupnpc-dev libgmp-dev libgmp3-dev autoconf autogen automake libtool

######################
# Swap file creation #
#      and setup.    #
######################

dd if=/dev/zero of=/var/swap.img bs=1024k count=1000
mkswap /var/swap.img
swapon /var/swap.img

chmod 0600 /var/swap.img
chown root:root /var/swap.img

echo "/var/swap.img none swap sw 0 0" >> /etc/fstab


#########################
# Git cloning and build #
#########################

cd $HOME
git clone https://github.com/rupeedigitalassets/Rupee-Core.git
cd Rupee-Core/src
make -f makefile.unix

###########################
# Initial setup of Rupeed #
###########################

./Rupeed -daemon
sleep 5
./Rupeed stop

# Put all necessary information
# in Rupee.conf
cd $HOME
echo "rpcuser=$rpcuser" > .RupeeCore/Rupee.conf
echo "rpcpassword=$rpcpassword" >> .RupeeCore/Rupee.conf
echo "rpcallowip=127.0.0.1" >> .RupeeCore/Rupee.conf
echo "listen=1" >> .RupeeCore/Rupee.conf
echo "server=1" >> .RupeeCore/Rupee.conf
echo "daemon=1" >> .RupeeCore/Rupee.conf
echo "logintimestamps=1" >> .RupeeCore/Rupee.conf
echo "maxconnections=64" >> .RupeeCore/Rupee.conf
echo "masternode=1" >> .RupeeCore/Rupee.conf
echo "externalip=$ServerIP" >> .RupeeCore/Rupee.conf
echo "bind=$ServerIP" >> .RupeeCore/Rupee.conf
echo "masternodeaddr=$ServerIP" >> .RupeeCore/Rupee.conf
echo "masternodeprivkey=XXXXXXXXXXX" >> .RupeeCore/Rupee.conf
echo "port=8517" >> .RupeeCore/Rupee.conf
echo "rpcport=8518" >> .RupeeCore/Rupee.conf

###################
# Folder Creation #
###################

mkdir $MasternodeDataDir

# Create all the folders you need
for i in `seq $StartingNode $EndingNode`; do
	cp -r $HOME/.RupeeCore $MasternodeDataDir/$MasternodeDirName$i
done;

#########################################
# Rupeed.conf private key modifications #
#########################################	

for i in `seq $StartingNode $EndingNode`; do
	
	# Which Rupee file we're modifying this time
	RupeeFile=$MasternodeDataDir/$MasternodeDirName$i/Rupee.conf

	# We are looking for lots of x's
	search="XXXXXXXXXXX"

	# Get the current private key
	privkey=`head -$i $keys | tail -1`

	# Modify Rupee.conf
	sed -i "s/$search/$privkey/g" $RupeeFile
done;
	
	

##################################
# Rupeed.conf port modifications #
##################################

# x is the main communications port
# y is the rpc port
x=`expr $z + 2`
y=`expr $x + 1`

StartingNode=`expr $StartingNode + 1`

# Modify the files.
for i in `seq $StartingNode $EndingNode`; do 
	
	# Current Rupee.conf to modify
	RupeeFile=$MasternodeDataDir/$MasternodeDirName$i/Rupee.conf

	# Change the port number in the conf
	sed -i "s/$z/$x/g" $RupeeFile 

	# Update z so we can change it
	z=`expr $z + 1`

	# Change the rpc port
	sed -i "s/$z/$y/g" $RupeeFile

	# x is the next port
	x=`expr $x + 2` 

	# y is the next rpcport
	y=`expr $x + 1`

	# update z so we can start over
	z=8517
done;

echo .
echo .
echo "The script has completed running."
echo "Please check some Rupee.conf files to verify your private keys are correct"
echo "These are all located in $MasternodeDataDir/MasternodeX (Where X is the "
echo "masternode number)"
echo "$EndingNode Masternodes were set up."
echo .
echo "A quick way to check the first masternode is to run the following command:"
echo "cat $MasternodeDataDir/Masternode1/Rupee.conf"
echo .
echo "To check others, just change the 1 to a 2 (or a 3, or 4, etc)"
echo "I recommned checking at least the first and last Rupee.conf files."
echo .
