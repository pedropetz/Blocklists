#!/bin/bash

DIR="/home/pihole/projectos/blocklists/"
LIST="binarydefense"

wget -O "$DIR"lists/"$LIST" https://www."$LIST".com/banlist.txt > /dev/null 2> "$DIR"logs/"$LIST".err

date >> "$DIR"logs/"$LIST".txt