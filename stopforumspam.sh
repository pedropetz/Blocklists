#!/bin/bash

DIR="/home/pihole/projectos/blocklists/"
LIST="stop_forum_spam"

#wget -O "$DIR"lists/"$LIST"_365 http://www.stopforumspam.com/downloads/listed_ip_365.zip > /dev/null 2> "$DIR"logs/"$LIST"_365.err
#wget -O "$DIR"lists/"$LIST"_30 http://www.stopforumspam.com/downloads/listed_ip_30.zip > /dev/null 2> "$DIR"logs/"$LIST"_30.err
#wget -O "$DIR"lists/"$LIST"_1 http://www.stopforumspam.com/downloads/listed_ip_1.zip > /dev/null 2> "$DIR"logs/"$LIST"_1.err

date >> "$DIR"logs/"$LIST".txt