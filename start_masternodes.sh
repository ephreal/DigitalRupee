#!/bin/bash
#
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
# Version: 1.0
# Release date: June 19, 2018 (2018-06-19)
#


# This script will automatically start all the masternodes
# contained in the masternodes directory. You will have to
# specify the location of the Rupeed executable, the location
# of the masternode directory, and how many masternodes there
# are. As this was set up for someone without programming
# experience, the numbering system starts at 1. This can
# be easily changed.

Rupee_Daemon=/root/Rupee-Core/src/Rupeed
Masternode_Root_Dir=/root/Masternodes
Masternode_Dir_Names=Masternode
First_Node=1
Last_Node=`cat settings.txt | grep amount_of_masternodes | cut -d "=" -f2`

for i in `seq $First_Node $Last_Node`; do
        $Rupee_Daemon -datadir=$Masternode_Root_Dir/$Masternode_Dir_Names$i
        echo "Starting masternode in $Masternode_Root_Dir/$Masternode_Dir_Names$i...."
        done;

