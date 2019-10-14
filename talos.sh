#!/bin/bash

DIR="/home/pihole/projectos/blocklists/"
LIST="talos"

#wget -O "$DIR"lists/"$LIST" http://"$LIST"intel.com/feeds/ip-filter.blf > /dev/null 2> "$DIR"logs/"$LIST".err

date >> "$DIR"logs/"$LIST".txt