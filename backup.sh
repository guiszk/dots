#!/bin/bash

# usage: ./backup.sh <folder> (defaults to ~/dots)
if [[ $# -eq 1 ]]; then
        FOLDER=$1
else
        FOLDER=~/dots
fi


[[ ! -d $FOLDER ]] && mkdir $FOLDER

rsync -P -a -v {.bashrc,.zshrc,.vimrc,.setscreen.sh,backup.sh} $FOLDER
rsync -P -a -v -r {.vim,.config} $FOLDER
rm -rf $FOLDER/.config/{spotify,libreoffice,dconf,gtk-3.0}
crontab -l > $FOLDER/crontab.txt

Value1=$(cat ~/dots/.datelog.txt)
Value2=$(date)
D1=$(date -d "$Value1" '+%s'); D2=$(date -d "$Value2" '+%s')
echo Last backup: "$(((D2-D1)/86400))d:$(date -u -d@$((D2-D1)) +%Hh:%Mm)" ago

echo Backup done!
date > $FOLDER/.datelog.txt
