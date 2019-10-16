#!/bin/bash

PROJDIR="/home/pihole/Blocklists"

DIRLSTS="$PROJDIR/lists"

WHITELST="$PROJDIR/whitelist.txt"
FINALLST="$PROJDIR/finallist.txt"

NLINES=0

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

resolv_mask () {
    echo "" >> "$2";
    nmap -sL -n "$1" | awk '/Nmap scan report/{print $NF}' | tr -d "(" | tr -d ")" >> "$2";
    sed -i "s~$1~#~" "$list";
}

check_mask () {
    IPi=`ipcalc $2 | grep 'HostMin' | awk '{ print $2}'`;
    IPf=`ipcalc $2 | grep 'HostMax' | awk '{ print $2}'`;

    IPi1=`echo "$IPi" | cut -d "." -f1`;
    IPi2=`echo "$IPi" | cut -d "." -f2`;
    IPi3=`echo "$IPi" | cut -d "." -f3`;
    IPi4=`echo "$IPi" | cut -d "." -f4`;

    IPf1=`echo "$IPf" | cut -d "." -f1`;
    IPf2=`echo "$IPf" | cut -d "." -f2`;
    IPf3=`echo "$IPf" | cut -d "." -f3`;
    IPf4=`echo "$IPf" | cut -d "." -f4`;

    IPc1=`echo "$1" | cut -d "." -f1`;
    IPc2=`echo "$1" | cut -d "." -f2`;
    IPc3=`echo "$1" | cut -d "." -f3`;
    IPc4=`echo "$1" | cut -d "." -f4`;
    
    if [ $IPc1 -ge $IPi1 -a $IPc1 -le $IPf1 ]
    then
	if [ $IPc2 -ge $IPi2 -a $IPc2 -le $IPf2 ]
	then
	    if [ $IPc3 -ge $IPi3 -a $IPc3 -le $IPf3 ]
            then
		if [ $IPc4 -ge $IPi4 -a $IPc4 -le $IPf4 ]
		then
		    echo "oi"
		    echo "$1 $IPi $IPf"
		    echo "ai"
		    resolv_mask $2 $3
		fi
            fi
	fi
    fi
    

    }

check_block_lists () {
    for list in "$DIRLSTS"/*;
    do
	figlet "$(basename "$list")"
	NLINES=`cat "$list" | cut -d " " -f1 | grep "/" | grep -v "/32" | wc -l`
	CT=0
	cat "$list" | cut -d " " -f1 | grep "/" | grep -v "/32" | while read -r blockip
	do
	    CT=$(( CT +1 ))
	    echo "$CT/$NLINES"
	    cat "$WHITELST" | while read -r whiteip
	    do
		check_mask "$whiteip" "$blockip" "$list"
	    done
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
