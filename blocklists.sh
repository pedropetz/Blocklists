#!/bin/bash

PROJDIR="/home/pihole/Blocklists"

DIRLSTS="$PROJDIR/lists"

WHITELST="$PROJDIR/whitelist.txt"
FINALLST="$PROJDIR/finallist.txt"

sort_list () {
    sort -n $1 > $1".aux"
    mv $1".aux" $1
}

check_invalid () {
    str="$1"
    if [[ ${str:0:1} != "" ]] && [[ ${str:0:1} != "#" ]] 
    then
	if [[ $1 =~ "/" ]]
	then
	    check_mask $1;
	else
	    check_white_lst "$1";
	fi
    fi
}

check_dupp () {
    time TRUE=`grep "$1" "$FINALLST" | wc -l`
    
    N1=`echo $1 | cut -d "." -f1`
    
    if [ $TRUE -eq 0 ]
    then
	echo "$1" >> "$FINALLST";
    fi
}

check_white_lst (){
    cat "$WHITELST" | while read -r line
    do
        CK=`grep "$line" "$1" | wc -l`
	
	if [ $CK -gt 0 ]
	then
            sed -i "s~$line~#~" "$1";
	fi
    done
}

check_mask () {
    echo "" >> "$2";
    nmap -sL "$1" | awk '/Nmap scan report/{print $NF}' | tr -d "(" | tr -d ")" >> "$2";
    sed -i "s~$1~#~" "$list";
}

check_block_lists () {
    for list in "$DIRLSTS"/*;
    do
	figlet "$(basename "$list")"
	cat "$list" | cut -d " " -f1 | grep "/" | grep -v "/32" | while read -r line
	do
	    echo "$line"
	    check_mask "$line" "$list";
	done

	check_white_lst $list
	
	sort_list "$list";

	figlet "$(basename "$list")" >> "$FINALLST";
	
	cat "$list" >> "$FINALLST";
	echo -e "\n\n" >> "$FINALLST";
    done
}


rm "$FINALLST"; touch "$FINALLST";

#check_white_lst 174.129.25.172
#check_mask 174.129.25.175
#check_white_lst 174.129.25.172
#check_white_lst 174.129.25.170
#check_white_lst 174.129.25.171

check_block_lists

### retirar / do IP
