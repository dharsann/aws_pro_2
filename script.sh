#!/bin/bash

sudo adduser userA
echo 'userA:passwordA' | sudo chpasswd
sudo mkdir -p /home/userA/A
sudo chown -R userA:userA /home/userA/A

sudo adduser userB
echo 'userB:passwordB' | sudo chpasswd
sudo mkdir -p /home/userB/B
sudo chown -R userB:userB /home/userB/B

sudo sed -i '/Subsystem sftp /c\Subsystem sftp internal-sftp' /etc/ssh/sshd_config

echo 'Match User userA' | sudo tee -a /etc/ssh/sshd_config
echo '  ChrootDirectory /home/userA' | sudo tee -a /etc/ssh/sshd_config
echo '  ForceCommand internal-sftp' | sudo tee -a /etc/ssh/sshd_config
echo '  AllowTcpForwarding no' | sudo tee -a /etc/ssh/sshd_config

echo 'Match User userB' | sudo tee -a /etc/ssh/sshd_config
echo '  ChrootDirectory /home/userB' | sudo tee -a /etc/ssh/sshd_config
echo '  ForceCommand internal-sftp' | sudo tee -a /etc/ssh/sshd_config
echo '  AllowTcpForwarding no' | sudo tee -a /etc/ssh/sshd_config

sudo systemctl restart sshd
