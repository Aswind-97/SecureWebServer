#!/bin/bash
#Implementation script to configure Ubuntu firewall, Snort, MYSQL, & Iptables
echo "Beginning implementation"
#########################################################

#CONFIGURE SNORT
#Validate snort install
sudo snort -T -i eth0 -c /etc/snort/snort.conf
echo "Snort has been validated."
#########################################################

#CONFIGURE UBUNTU FIREWALL
#Enable firewall
sudo ufw enable
#Allow incoming HTTP/HTTPS traffic through firewall for Apache
sudo ufw allow in "Apache"
#Open the SSH port through firewall
sudo ufw allow ssh
#Ensures status of UFW is active
sudo ufw status
#Displays application profile
sudo ufw app list

#########################################################

#CONFIGURE MYSQL FOR SECURITY PURPOSES
#Input 'y' for all questions and input password
sudo mysql_secure_installation

#########################################################

#CoONFIGURE IPTABLES
echo "Cleaning/Removing up default rules"
sudo iptables -F

echo "Setting default Policies to DROP all traffic"
sudo iptables -P INPUT DROP
sudo iptables -P FORWARD DROP
sudo iptables -P OUTPUT DROP

echo "Allow all incoming web traffic HTTP"
sudo iptables -A INPUT -p tcp --dport 80 -m state --state NEW,ESTABLISHED -j ACCEPT
sudo iptables -A OUTPUT -p tcp --sport 80 -m state --state ESTABLISHED -j ACCEPT

echo "Allow all incoming web traffic HTTPS"
sudo iptables -A INPUT -p tcp --dport 443 -m state --state NEW,ESTABLISHED -j ACCEPT
sudo iptables -A OUTPUT -p tcp --sport 443 -m state --state ESTABLISHED -j ACCEPT

echo "Allow all outgoing web traffic HTTP"
sudo iptables -A OUTPUT -p tcp --dport 80 -m state --state NEW,ESTABLISHED -j ACCEPT
sudo iptables -A INPUT -p tcp --sport 80 -m state --state ESTABLISHED -j ACCEPT

echo "Allow all outgoing web traffic HTTPs"
sudo iptables -A OUTPUT -p tcp --dport 443 -m state --state NEW,ESTABLISHED -j ACCEPT
sudo iptables -A INPUT -p tcp --sport 443 -m state --state ESTABLISHED -j ACCEPT

echo "Allow port used for mailer communication"
sudo iptables -A INPUT -p tcp --dport 465 -m state --state NEW,ESTABLISHED -j ACCEPT
sudo iptables -A OUTPUT -p tcp --sport 465 -m state --state ESTABLISHED -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 25 -m state --state NEW,ESTABLISHED -j ACCEPT
sudo iptables -A OUTPUT -p tcp --sport 25 -m state --state ESTABLISHED -j ACCEPT

echo "Allow all outgoing mailer communication"
sudo iptables -A OUTPUT -p tcp --dport 465 -m state --state NEW,ESTABLISHED -j ACCEPT
sudo iptables -A INPUT -p tcp --sport 465 -m state --state ESTABLISHED -j ACCEPT
sudo iptables -A OUTPUT -p tcp --dport 25 -m state --state NEW,ESTABLISHED -j ACCEPT
sudo iptables -A INPUT -p tcp --sport 25 -m state --state ESTABLISHED -j ACCEPT

echo "Allow all ssh communication"
sudo iptables -A INPUT -p tcp --dport 22 -m state --state NEW,ESTABLISHED -j ACCEPT
sudo iptables -A OUTPUT -p tcp --sport 22 -m state --state ESTABLISHED -j ACCEPT

echo "Allow outbound DNS"
sudo iptables -A OUTPUT -p udp --dport 53 -j ACCEPT
sudo iptables -A INPUT -p udp --sport 53 -j ACCEPT
sudo iptables -A OUTPUT -p tcp --dport 53 -m state --state ESTABLISHED -j ACCEPT
sudo iptables -A INPUT -p tcp --sport 53 -m state --state NEW,ESTABLISHED -j ACCEPT

echo "Allow inbound DNS"
sudo iptables -A INPUT -p udp --dport 53 -j ACCEPT
sudo iptables -A OUTPUT -p udp --sport 53 -j ACCEPT
sudo iptables -A OUTPUT -p tcp --dport 53 -m state --state ESTABLISHED -j ACCEPT
sudo iptables -A INPUT -p tcp --sport 53 -m state --state NEW,ESTABLISHED -j ACCEPT

echo "Prevent DOS Attacks"
sudo iptables -A INPUT -p tcp --dport 80 -m limit --limit 25/minute --limit-burst 100 -j ACCEPT

echo "Prevent Brute Force Attacks"
sudo iptables -N BRTBLK
sudo iptables -A INPUT -p tcp --dport 22 -m state --state NEW -j BRTBLK
sudo iptables -A BRTBLK -m recent --set --name SSH
sudo iptables -A BRTBLK -m recent --update --seconds 45 --hitcount 5 --name SSH -j LOG --log-level info --log-prefix "Bad IP : "
sudo iptables -A BRTBLK -m recent --update --seconds 45 --hitcount 5 --name SSH -j DROP

echo "Log Dropped Packets"
sudo iptables -N LOGGING
sudo iptables -A INPUT -j LOGGING
sudo iptables -A LOGGING -m limit --limit 2/min -j LOG --log-prefix "IPTables Packet Dropped: " --log-level 7
sudo iptables -A LOGGING -j DROP
echo "IPTables Configured"

#########################################################

echo "Implementation complete"
#End of implementation script
