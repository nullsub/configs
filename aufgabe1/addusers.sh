#! /bin/bash
if [ "$EUID" -ne 0 ]
      then echo "Please run as root"
      exit
fi
while read line
do
    name=${line,,}
    IFS=' ' read -a array <<< "$name"
    fn=${array[0]}
    ic=${fn:0:1}
    ln=${array[1]}
    _username=$ic$ln
    _username0=$_username

    counter=0
    while id -u $_username >/dev/null 2>&1
    do
        _username=$_username0$counter
        let "counter++"
    done



    useradd ${_username} -d /home/${_username} -s /bin/bash -U -m -p `mkpasswd ${_username}`
    #cp -rf /etc/skel/. /home/${_username}
    _home=/home/${_username}
    mkdir ${_home}/.ssh
    ssh-keygen -q -b 1024 -f ${_home}/.ssh/id_rsa -N ''
    cat ${_home}/.ssh/id_rsa.pub >> ${_home}/.ssh/authorized_keys
    rm ${_home}/.ssh/id_rsa.pub
    touch ${_home}/.ssh/known_hosts
    echo "StrictHostKeyChecking no" >> ${_home}/.ssh/config
    chown -R ${_username}:${_username} ${_home}/
done < $1
