#!/bin/bash

DIR="/home/pihole/projectos/blocklists/"
LIST="tor_nodes"

wget -O "$DIR"lists/"$LIST" https://www.dan.me.uk/torlist/ > /dev/null 2> "$DIR"logs/"$LIST".err

date >> "$DIR"logs/"$LIST".txt