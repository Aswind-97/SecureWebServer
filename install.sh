
#!/bin/bash
#Installation script for LAMP stack, SSH, Iptables, & Snort
echo "Beginning installation"
#########################################################

#UPDATE SOURCES
sudo apt update

#########################################################

#LAMP STACK INSTALL
sudo apt-get install -y lamp-server^

#########################################################

#OPENSSH INSTALL
sudo apt install -y  openssh-server

#########################################################

#IPTABLES INSTALL
sudo apt-get install -y iptables

#########################################################

#SNORT INSTALL
#Run <$ ip address> to see network names and ip addresses to be used
#for config of installation. Navigate configuration menu using "tab"
#button to hover over "OK" and press "enter" button to click "OK"
#Enter network interface name for example: <enp0s3>
#Enter ip address for example: <192.168.56.128/24>
sudo apt-get install -y snort

#########################################################
echo "Installation complete"

#End of installation script
