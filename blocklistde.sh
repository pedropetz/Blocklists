#!/bin/bash

DIR="/home/pihole/projectos/blocklists/"
LIST="block_list_de"

#wget -O "$DIR"lists/"$LIST"_all http://lists.blocklist.de/lists/all.txt > /dev/null 2> "$DIR"logs/"$LIST"_all.err
#wget -O "$DIR"lists/"$LIST"_3600 https://api.blocklist.de/getlast.php?time=3600 > /dev/null 2> "$DIR"logs/"$LIST"_3600.err

date >> "$DIR"logs/"$LIST".txt