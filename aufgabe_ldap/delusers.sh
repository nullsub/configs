#! /bin/bash

if [ "$EUID" -ne 0 ]
      then echo "Please run as root"
      exit
fi

while read line
do
    _username=$line

    delUser="uid=$_username,ou=Users,dc=cluster,dc=local"
    delGroup="cn=$_username,ou=Groups,dc=cluster,dc=local"
    ldapdelete -cxD cn=admin,dc=cluster,dc=local -w secret "$delUser"
    ldapdelete -cxD cn=admin,dc=cluster,dc=local -w secret "$delGroup"
    

    rm -r /home/${_username}
done < $1
rm un_pw
rm ldapusers_new
