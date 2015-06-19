#! /bin/bash

#DIR="/var/www/upload"
DIR="."

for d in $(ls -d */) ; do
    echo $d
    name=$(expr "$d" : '\(^[a-zA-Z]*\)')
    unit=${d##[A-Za-z]*[0-9]}
    unit=${unit%\/}
    nb=${d%[DH]\/}
    nb=${nb##[A-Za-z]*[A-Za-z]}
    echo $name $nb $unit
    if [ $unit == 'D' ] ; then
	del=$(find $DIR -type d -mtime +$nb -name $name$nb$unit -exec rm -rf {} \;)
    elif [ $unit == 'H' ] ; then
	del=$(find $DIR -type d -mmin +$(($nb*60)) -name $name$nb$unit -exec rm -rf {} \;)
    fi
done
