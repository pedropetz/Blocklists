#!/bin/bash

DIR="/home/pihole/projectos/blocklists/"
LIST="emerging_threats"

#wget -O "$DIR"lists/"$LIST"1 https://rules.emergingthreats.net/fwrules/emerging-Block-IPs.txt  > /dev/null 2> "$DIR"logs/"$LIST"1.err
#wget -O "$DIR"lists/"$LIST"2 https://rules.emergingthreats.net/blockrules/compromised-ips.txt > /dev/null 2> "$DIR"logs/"$LIST"2.err

date >> "$DIR"logs/"$LIST".txt