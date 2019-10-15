#!/bin/bash

DIR="/home/pihole/projectos/blocklists/"
LIST="firehol"

wget -O "$DIR"lists/"$LIST" https://raw.githubusercontent.com/"$LIST"/blocklist-ipsets/master/"$LIST"_level3.netset > /dev/null 2> "$DIR"logs/"$LIST".err

date >> "$DIR"logs/"$LIST".txt