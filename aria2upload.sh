#!/bin/bash
path=$3
downloadpath='$HOME/Download'
if [ $2 -eq 0 ]
        then
                exit 0
fi
while true; do
filepath=$path
path=${path%/*};
if [ "$path" = "$downloadpath" ] && [ $2 -eq 1 ]
    then
    bash $HOME/file2od.sh $filepath
    exit 0
elif [ "$path" = "$downloadpath" ]
    then
    exit 0
fi
done
