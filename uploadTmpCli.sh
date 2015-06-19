#! /bin/bash

USER="MyUser"
HOST="mydomain.com"
DIR='/var/www/upload'
URLBASE='/upload/' #For example : mydomain.com/upload/


function err {
    echo "Erreur : $1"
    exit 1
}

function usage {
    echo "Usage : $0 FILE duration[H|D]"
    exit 1
}

if [[ $# -lt 1 || $# -gt 2 ]] ; then
    usage
fi

if [[ ! -f $1 || ! -e $1 ]] ; then
    err "$1 : No such file or directory"
fi

suf="1D"

if [[ $# -eq 2 ]] ; then
    len=${#2}
    unit=${2:len-1:1}
    nb=${2:0:len-1}
    if [[ $unit =~ [HD] && $nb =~ [[:digit:]]$ ]] ; then
	suf=$2
    else
	usage
    fi
fi

namedir=$(cat /dev/urandom | tr -dc 'a-zA-Z' | fold -w 8 | head -n 1)$suf

rsync -aqzP $1 $USER@$HOST:$DIR/$namedir/
echo $HOST$URLBASE$namedir'/'$1
