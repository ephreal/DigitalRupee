# DigitalRupee
The scripts in this repository are used to set up multiple masternodes on one linux server. The scripts have only been tested on Ubuntu (*Shudder*), and will probably only work on Ubuntu (*Shudder*) because the instructions provided were only for Ubuntu (*Double Shudder*). With a little work, the scripts could be made to work on a wide variety of Linux O/S, but I don't have the time to work on that at the moment.

This repository contains:  
keys.txt - Where you place the masternode private keys.  
rupee_masternode_setup.sh - The setup script that will set up all needed folders for you. You will need to modify, at minimum, the rpcuser, rpcpassword, ServerIP, and EndingNode variables to suit your install.  
start_masternodes.sh - The script that will run all the masternodes in the masternode directory. If you made any changes to the masternode variable in the rupee_masternode_setup.sh, you will need to change that here. You will also need to change the $Last_Node variable to match your setup.  

All in all, to use this setup requires making a minimum of 4 changes to 3 text files. A sample setup will be posted here eventually.


# Example Usage

## Download

First make sure you have followed the Rupee masternode setup steps for the wallet.  
By this point you should have all your private keys ready, your masternode server installed, and you should be logged in as root.  

Start by going to your home directory.
```
cd $HOME
```

Clone this repository. To clone the repository. To ensure you have git installed and run the following commands.  
```
apt-get install git
git clone https://github.com/ephreal/DigitalRupee
```

## Initial setup

Once downloaded, go into the directory.
```
cd DigitalRupee
```

Edit the keys.txt file. I recommend reading the usage in the file, deleting everything in the file, and then placing your keys in it.  
To view and edit the file, type
```
nano keys.txt
```

Once you have added your keys to the file, type
```
chmod +x *.sh
```

## Setting up private keys and server IP

We are now ready to make your changes to the rupee_masternode_setup.sh. 
```
nano rupee_masternode_setup.sh
```

Scroll down past the licensing information and modify the ServerIP and EndingNode.
```
ServerIP=YOUR_SERVER_IP_HERE

EndingNode=AMOUNT_OF_MASTERNODES_TO_SETUP
```
I also recommend changing the rpcuser and the rpcpassword to something random as well.


## Running the script

Once you have completed that, save the file. We are now ready to run it.
```
./rupee_masternode_setup.sh
```

Wait a while for this to complete. You will receive an error message about a missing file at the end, which is to be expected and ok.

## Verifying your conf files are correct

Your masternodes should now be fully ready to start. Check a few of the Rupee.conf files just to make sure your private keys are there.
```
cat /root/Masternodes/Masternode1/Rupee.conf
cat /root/Masternodes/Masternode3/Rupee.conf
```

## Starting the masternodes

Once you're ready to run the masternodes, modify the start_masternodes.sh to reflect how many masternodes your are running.  
To do this, edit the file and change the Last_Node variable to how many you have.
```
LastNode=20
```

Once you have saved the file, run the script
```
./start_masternodes.sh
```

You're done. Anytime the server goes down or needs to be restarted, log into the server and run the start_masternodes.sh to start them all up again. 
While making the script run shortly after startup is possible, that's outside the scope of this tutorial.


If these scripts helped you at all, please send a few coins my way.  
Bitcoin
```
1F6SExymCmQWx3r6Bjr5uYjinHqdksWMKQ
```

Defcoin
```
DG2KCYZxy8s6Navqe7rQA5N11WPKdeJ9dH
```

Etherium
```
0x5b7f449332F6E2054027424724bB1b7C30BDDB63
```
(Note: I know that looks like a Hex number... it's not. I love it.)  

Rupee
```
RPczTav89pMtz97QYGncMJYps6DV1YPTuG
```
