#! /bin/bash
read -p "Username:" _username
adduser --geco GECO  ${_username}
_home=/home/${_username}
mkdir ${_home}/.ssh
ssh-keygen -q -b 1024 -f ${_home}/.ssh/id_rsa -N ''
cat ${_home}/.ssh/id_rsa.pub >> ${_home}/.ssh/authorized_keys
rm ${_home}/.ssh/id_rsa.pub
touch ${_home}/.ssh/known_hosts
echo "StrictHostKeyChecking no" >> ${_home}/.ssh/config
chown -R ${_username}:${_username} ${_home}/.ssh 
