#!/bin/bash

if [ -z "$1" ];
then
JPGS=`find $(pwd) -maxdepth 1 -name "*.jpg"`
fi

if [[ $1 == *"FILE"* ]];
then
JPGS=`cat $2`
fi

MIN="360"
for VAR in $JPGS
do
HT=`identify -format %h $VAR 2>/dev/null`
WT=`identify -format %w $VAR 2>/dev/null`

if [[ "$HT" -le "$MIN" && "$WT" -le "$MIN" ]];
then continue
fi

HTPROC=$(($MIN*100/$HT))
WTPROC=$(($MIN*100/$WT))

VAR2=$(dirname $VAR)/$(basename $VAR .jpg)_thumbnail.jpg

if [[ "$HTPROC" -ge "WTPROC" ]];
then
convert $VAR -resize $WTPROC% $VAR2 2>/dev/null
else
convert $VAR -resize $HTPROC% $VAR2 2>/dev/null
fi

done
