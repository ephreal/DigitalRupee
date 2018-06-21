# DigitalRupee
The scripts in this repository are used to set up multiple masternodes on one linux server. The scripts have only been tested on Ubuntu (*Shudder*), and will probably only work on Ubuntu because the instructions provided were only for Ubuntu. With a little work, the scripts could be made to work on a wide variety of Linux O/S, but I don't have the time to work on that at the moment.

This repository contains:  
  * keys.txt - Where you place the masternode private keys.  
  * rupee_masternode_setup.sh - The setup script that sets everything up for you.
  * start_masternodes.sh - The script that will run all the masternodes in the masternode directory.  
  * settings.txt - The file you modify for your setup.  

The example below assumes the following:  
  1. You have set up your wallet  
  2. You have a text file with all your masternode private keys  
  3. You have an Ubuntu server up and running  
  4. You are logged into the server as root.  
  5. You are not afraid to copy/paste commands (You really don't need to know what they do for them to work.... I swear!).  

If you wish to copy and paste as many commands as possible at once, go to the bottom of the readme for a shortened version.

# Example

## Download


Start by going to your home directory.
```
cd $HOME
```

Clone my repository. To do this, run the following commands:   
```
apt-get install -y git
git clone https://github.com/ephreal/DigitalRupee
```

## Initial setup

Once downloaded, go into the directory.
```
cd DigitalRupee
```

Edit the keys.txt file. I recommend reading the usage first. Then delete everything in the file and place your keys in it.  

To view and edit the file, type
```
nano keys.txt

```

Hit Ctrl+x at the same time, then y for yes, then enter to save the file.

Once you have added your keys to the file, type
```
chmod +x *.sh
```

## Setting up your info

We are now ready to make your changes to the settings.txt. 
```
nano settings.txt
```

You will want to change anything after an equals sign in this file. (Except keys.txt unless you know what you're doing). For the rpcuser and rpcpassword, I recommend using a mix of uppercase, lowercase, and numbers. Make the username at least 8 characters long, and the password at least 16. You will not need to remember these after setup.  

For example:  
```
private_key_file=keys.txt

server_ip=YOUR_SERVER_IP_HERE

amount_of_masternodes=AMOUNT_OF_MASTERNODES_TO_SETUP

rpcuser=RANDOM_NAME_HERE

rpcpassword=RANDOM_PASSWORD_HERE

```

Hit Ctrl and X at the same time, then hit  y for yes, and then enter to save the file.

## Running the script

Once you have completed that, save the file. We are now ready to run it.
```
./rupee_masternode_setup.sh
```

## Verifying your conf files are correct

Your masternodes should now be fully ready to start. Check a few of the Rupee.conf files just to make sure your private keys are there.
```
cat /root/Masternodes/Masternode1/Rupee.conf
cat /root/Masternodes/Masternode3/Rupee.conf
```

## Starting the masternodes

Once you're ready to run the masternodes, run the start_masternodes.sh script
```
./start_masternodes.sh
```

You're done. Anytime the server goes down or needs to be restarted, log into the server and run the start_masternodes.sh to start them all up again. 
While making the script run shortly after startup is possible, that's outside the scope of this tutorial.


## Shortened Version

This is recommended for people who understand the above steps. The code is the same as above, thre's just less explanation.

Copy and paste the following into the terminal.
```
cd $HOME
apt-get install -y git
git clone https://github.com/ephreal/DigitalRupee
cd DigitalRupee
chmod +x *.sh
nano keys.txt
```

Add your keys to the file. Hit Ctrl + X , then hit y for yes, then enter to save the file.

```
nano settings.txt
```
Modify everything as explained in **Setting up your info** above. Save the file.


```
./rupee_masternode_setup.sh
cat /root/Masternodes/Masternode1/Rupee.txt
cat /root/Masternodes/Masternode2/Rupee.txt
```

If all is good, start the masternodes
```
./start_masternodes.sh
```


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
