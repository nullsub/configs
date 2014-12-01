#! /bin/bash

if [ "$EUID" -ne 0 ]
      then echo "Please run as root"
      exit
fi

baseid=2001
touch un_pw
touch ldapusers_new
chmod 640 un_pw

while read line
do
    
    _username=$line

    _username0=$_username

    counter=0
    while grep -Fxq $_username ldapusers_new
    do
        _username=$_username0$counter
        let "counter++"
    done
	



    lf=$_username.ldif
    touch $lf
    echo "# User primary group" >> $lf
    echo "dn: cn=$_username,ou=Groups,dc=cluster,dc=local" >> $lf
    echo "cn: $_username" >> $lf
    echo "objectClass: top" >> $lf
    echo "objectClass: posixGroup" >> $lf
    echo "gidNumber: $baseid" >> $lf
    echo "" >> $lf
    echo "# User account" >> $lf
    echo "dn: uid=$_username,ou=Users,dc=cluster,dc=local" >> $lf
    echo "cn: $_username" >> $lf
    #echo "givenName: $_username" >> $lf
    echo "sn: $_username" >> $lf
    echo "uid: $_username" >> $lf
    echo "uidNumber: $baseid" >> $lf
    echo "gidNumber: $baseid" >> $lf
    echo "homeDirectory: /home/$_username" >> $lf
    echo "objectClass: top" >> $lf
    echo "objectClass: posixAccount" >> $lf
    echo "objectClass: shadowAccount" >> $lf
    echo "objectClass: organizationalPerson" >> $lf
    echo "objectClass: person" >> $lf
    echo "loginShell: /bin/bash" >> $lf
    _pw=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9-$!"+/_%&(){}' | fold -w 8 | head -n 1)
    echo "userPassword: $_pw" >> $lf

    ldapadd -cxD cn=admin,dc=cluster,dc=local -w secret -f $lf

    rm $lf
    
    echo "$_username $_pw" >> un_pw
    echo "$_username" >> ldapusers_new

    baseid=$((baseid+1))
done < $1

