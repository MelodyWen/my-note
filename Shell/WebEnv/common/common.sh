#!/bin/bash

COMMON_DIR=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
source ${COMMON_DIR}/ansi.sh

# export LOG_PATH=/var/log/ubuntu-web.log
export WWW_USER="www-data"
export WWW_USER_GROUP="www-data"

CODENAME=$(lsb_release -c)
export CODENAME=${CODENAME#Codename:}

function call_function {
    func=$1
    desc=$2
    # log_file=$3
    # echo -n "===> ${desc}..."
    # $func >> ${log_file} 2>&1

    ansi --bold --green $desc
    echo -e "\n"

    $func
    ret=$?

    echo -n '    ['
    if [[ $ret -eq 0 ]]; then
        ansi --bold --green "DONE"
    else
        ansi --bold --red "ERROR"
    fi
    echo -e "]\n"
}

random_string(){
    length=${1:-32}
    echo `cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w ${length} | head -n 1`
}
