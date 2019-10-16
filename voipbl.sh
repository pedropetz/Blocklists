#!/bin/bash

DIR="/home/pihole/Blocklists/"
LIST="voip_bl"

wget -O "$DIR"lists/"$LIST" http://www.voipbl.org/update/ > /dev/null 2> "$DIR"logs/"$LIST".err

date >> "$DIR"logs/"$LIST".txt
