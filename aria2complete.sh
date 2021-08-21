#!/bin/bash
path=$3
if [ $2 -eq 0 ]
        then
                exit 0
fi
filepath=$path
echo $filepath >> "$HOME/.aria2/aria2.filelist"
cd $HOME
bash $HOME/file2od.sh $filepath
