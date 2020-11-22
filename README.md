# SecureWebServer

A Secure Web Server and Login System

In this project, you are to prepare a web server and a website for a small business company. The company is a typical small business company with medium hit-rate site visits for their webpage and very interested in security while not significantly compromising usability. Your design decisions should take these into consideration. 

1. Preparing the web server You will prepare a web server on the latest version of Ubuntu (a Linux distribution) along with necessary security tools to protect it from popular attacks using the most popular firewall (IPTables) and intrusion detection system (Snort). Note that the web server is also a SSH server, so you are required to install OpenSSH, and allow SSH traffic to go through as well. You will install, configure, and implement your designed policies using these two security tools. You are required to install LAMP (Linux, Apache, MySQL, PHP stack) on Ubuntu with necessary configurations suitable for your design and implementation. 

You will write two shell scripts to automate the installation and configuration of your system for disaster recovery purposes with comments for every single command: 

installation.sh: It will include all the commands regarding installation of all the necessary services and tools. Also, all configuration scripts for LAMP.implementation.sh: It will include all the commands regarding implementing policies for your firewall, IDS, etc. You may use a stream editor such as “sed” to implement them using your automated scripts, if that requires editing specific files. 

**************************** NOTE!*****************************************

Ran on a VM using Virtual Box and Ubuntu 20. 

If using an earlier version of Ubuntu, all but SNORT should work. 
