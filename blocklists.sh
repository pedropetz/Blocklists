#!/bin/bash

DIRLSTS="/home/pihole/projectos/blocklists/lists"

WHITELST="/home/pihole/projectos/blocklists/whitelist.txt"
FINALLST="/home/pihole/projectos/blocklists/finallist.txt"

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
    : '
    while IFS= read -r line
    do
        #echo "checking.. $line"
        if [ $line == $1 ]
        then
            TRUE=1;
	    echo "Entra na dupp_T";
            break;
        fi

	NL=`echo $line | cut -d "." -f1`
	
	if [ $NL -gt $N1  ]
	then
	    TRUE=0;
	    echo "Entra na dupp_F $line:$1";
	    break;
	fi
	
	
    done < "$FINALLST"
    '
    if [ $TRUE -eq 0 ]
    then
	echo "$1" >> "$FINALLST";
    fi
}

check_white_lst (){
    TRUE=`grep "$1" "$WHITELST" | wc -l`

    N1=`echo $1 | cut -d "." -f1`

    
    : '
    while IFS= read -r line
    do
	#echo "checking.. $line"
	if [ $line == $1 ]
	then
	    TRUE=1;
	    echo "Entra na white_T";
	    break;
	fi
	
	NL=`echo $line | cut -d "." -f1`
	
        if [ $NL -gt $N1  ]
        then
            TRUE=0;
	    echo "Entra na white_F $line:$1";
            break;
        fi
	
	
    done < "$WHITELST"
    '
    
    if [ $TRUE -eq 0 ]
    then
        check_dupp $1
    fi
}

check_mask () {
    nmap -sL "$1" | awk '/Nmap scan report/{print $NF}' | tr -d "(" | tr -d ")" | while read line; do
	
        check_white_lst "$line";
    done
}

check_block_lists () {
    for list in "$DIRLSTS"/*;
    do
	while IFS= read -r line; do
	    AUX=`echo $line | cut -d " " -f1`
	    
	    check_invalid "$AUX"
	done < "$DIRLSTS/$(basename "$list")"
	sort_list "$list";
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
