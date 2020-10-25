#!/bin/bash
##Destruction.sh - checks balances and removes any addresses from dumpwallet.txt with 0 inputs
#####################################################################
#"dumpwallet dumpwallet.txt" and put in same directory as this script
#####################################################################
#then run this script
#might want staking=0 in denarius.conf until everything is done
#stop wallet, move wallet.dat to wallet.bak, open wallet, "importwallet cleaned.txt"
#wait for rescan, "tail -f debug.log" to watch
#once your balance shows up, stop wallet, staking=1, start wallet
#DONE
#requires config.conf and rpc.sh from https://github.com/buzzkillb/bash-denariusrpc
### THIS IS GOING TO PUT PRIVKEYS into a TEXTFILE, disconnecto internet or something when running ######
##### ALWAYS BACKUP wallet.dat ######

. config.conf
. rpc.sh

minimuminputs=0
zeroRewards=0.00000000

mv balance.txt balance.bak
mv cleaned.txt cleaned.bak

#deduplicate addresses
unspentaddresses=$(rpc_listunspent | jq -r '.[].address' | awk '!seen[$0]++')
while IFS= read -r
do
    printf '%s\n' $REPLY
    #count how many inputs and total balance per address
    #save any greater than 0 balance
    txamount=$(rpc_listunspent | jq --arg ADDRESS "$REPLY" '[.[] | select(.address == $ADDRESS) | .amount ] | add')
    txcount=$(rpc_listunspent | jq --arg ADDRESS "$REPLY" '[.[] | select(.address == $ADDRESS) | .txid ] | length')
    echo "inputs: $txcount"
    echo "amount: $txamount"
    
    	if [ 1 -eq "$(echo "${txamount} == ${zeroRewards}" | bc)" ]; then
		echo "skip $txamount"
	else
		echo "use $txamount"
		echo $REPLY >> balance.txt
	fi
done <<< "$unspentaddresses"

#Second Part
#scan through balance.txt and take any line from dumpwallet and put into cleaned.txt

while IFSBALANCE=, read -r input1; do
    echo "$input1"
    grep "${input1}" dumpwallet.txt >> cleaned.txt
done <balance.txt
