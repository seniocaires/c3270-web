#!/bin/bash

# max time in minutes
MAXTIME=15

OLDIFS=$IFS
IFS='
'


for i in `w | sed '1,3d' | awk '{ print $2,$5 }' | sed 's/:.*$//' | sed -e '/^.*[0-9]s$/d'`;
  do
    idletime=`echo $i |awk '{ print $2 }'`

    if [ $idletime -gt $MAXTIME ];
      then
        TTYTOKILL=`echo "$i" | awk '{print $1}' | sed 's/^.*\///'`
        NEWPIDSTOKILL=`ps -t $TTYTOKILL | awk '{print $1}' | sed '1d'`
        PIDSTOKILL=$(echo $PIDSTOKILL $NEWPIDSTOKILL)
    fi
  done

IFS=$OLDIFS

echo "killing:"
for ps in $PIDSTOKILL;
  do
    ps -f -p $ps | sed '1d'
    kill $(echo $ps)
  done
sleep 1
for ps in $PIDSTOKILL;
  do
    kill -9 $(echo $ps)
  done
