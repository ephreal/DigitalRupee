# DigitalRupee
The scripts in this repository are used to set up multiple masternodes on one linux server. The scripts have only been tested on Ubuntu (*Shudder*), and will probably only work on Ubuntu (*Shudder*) because the instructions provided were only for Ubuntu (*Double Shudder*). With a little work, the scripts could be made to work on a wide variety of Linux O/S, but I don't have the time to work on that at the moment.

This repository contains:
keys.txt - Where you place the masternode private keys.
rupee_masternode_setup.sh - The setup script that will set up all needed folders for you. You will need to modify, at minimum, the rpcuser, rpcpassword, ServerIP, and EndingNode variables to suit your install.
start_masternodes.sh - The script that will run all the masternodes in the masternode directory. If you made any changes to the masternode variable in the rupee_masternode_setup.sh, you will need to change that here. You will also need to change the $Last_Node variable to match your setup.

All in all, to use this setup requires making a minimum of 5 changes to 2 text files. A sample setup will be posted here eventually.
