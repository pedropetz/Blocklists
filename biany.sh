#!/bin/bash

DIR="/home/pihole/Blocklists/"
LIST="bi_any"

wget -O "$DIR"lists/"$LIST"_1 https://www.badips.com/get/list/any/2?age=1d > /dev/null 2> "$DIR"logs/"$LIST"_1.err
wget -O "$DIR"lists/"$LIST"_7 https://www.badips.com/get/list/any/2?age=7d > /dev/null 2> "$DIR"logs/"$LIST"_7.err
wget -O "$DIR"lists/"$LIST"_30 https://www.badips.com/get/list/any/2?age=30d > /dev/null 2> "$DIR"logs/"$LIST"_30.err

date >> "$DIR"logs/"$LIST".txt
