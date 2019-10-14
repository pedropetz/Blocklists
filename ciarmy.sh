#!/bin/bash

DIR="/home/pihole/projectos/blocklists/"
LIST="ci_army"

#wget -O "$DIR"lists/"$LIST" http://cinsscore.com/list/ci-badguys.txt > /dev/null 2> "$DIR"logs/"$LIST".err

date >> "$DIR"logs/"$LIST".txt