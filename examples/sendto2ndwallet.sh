#!/bin/bash
#Send D from each address in Master wallet, to a new address in destination wallet, to create many staking addresses of varying inputs.
. config.conf
. rpc.sh

txfee=0.00137331
minimuminputs=0
minimumbalance=0.00001000
zeroRewards=0.00000000
maximumInput=1.00000000

#functions used: rpc_listunspent rpc_createrawtransaction rpc_signrawtransaction rpc_sendrawtransaction

#Master wallet is using RPC, and destination wallet is using daemon to getnewaddress
#Pick the QT/Daemon of 2nd wallet below
denariusdaemon='/usr/local/bin/denariusd -datadir=/home/<user>/.denarius2/'
#denariusdaemon=denarius_1.daemon

#deduplicate addresses
unspentaddresses=$(rpc_listunspent | jq -r '.[].address' | awk '!seen[$0]++')
while IFS= read -r
do
    getNewAddress=($($denariusdaemon getnewaddress))
    echo "$getNewAddress new addy tester"
    printf '%s\n' $REPLY
    #count how many inputs per address
    txcount=$(rpc_listunspent | jq --arg ADDRESS "$REPLY" '[.[] | select(.address == $ADDRESS) | .txid ] | length')
    #echo "$txcount"
       #if address has minimuminputs then do this
       if [ "$txcount" -gt "$minimuminputs" ]; then
        echo "dedust addy: $REPLY"
        #get total balance per address
        sumdust=$(rpc_listunspent | jq --arg ADDRESS "$REPLY" '.[] | select(.address== $ADDRESS) | .amount | tonumber ' | jq -s add |  awk {' printf "%.8f",$1'})
        echo "denarii dust: $sumdust"
        subtractfee=$(echo "$sumdust - $txfee" | bc)
        #echo "$subtractfee"
           #check if minimumbalance is less than subtractfee
           if [ 1 -eq "$(echo "${minimumbalance} < ${subtractfee}" | bc)" ]
           then
     	      echo "Gonna send it!"
                rm raw.txt
		rpc_listunspent | jq --arg ADDRESS "$REPLY" '.[] | select(.address==$ADDRESS) | .txid,.vout,.amount ' |  (
		    while read txid; do
		        read vout
		        read amount
		        #if [ 1 -eq "$(echo "${amount} == ${zeroRewards}" | bc)" ] || [ 1 -eq "$(echo "${amount} > ${maximumInput}" | bc)" ]; then
		        if [ 1 -eq "$(echo "${amount} == ${zeroRewards}" | bc)" ]; then
		            echo "skip $amount"
		        else
		            echo "use $amount"
		            echo '{"txid":'$txid',"vout":'$vout'},' | tr -d ' \t\n\r\f' >> raw.txt
		        fi		        
		    done
		)
                QUOTE="'"
                sed -i '1s/^/'$QUOTE''$QUOTE'[/' raw.txt
		sed -i '$ s/,$//g' raw.txt
		echo ']'$QUOTE''$QUOTE', '$QUOTE''$QUOTE'{"'$getNewAddress'":'$subtractfee'}'$QUOTE''$QUOTE'' | tr -d ' \t\n\r\f' >> raw.txt
		#store rawtransaction
		startrawtransaction=$(head -1 raw.txt)
		#put startrawtransaction json into curl function command
		rpc_createrawtransaction "${startrawtransaction}"
		#bring full curl rpc string into _createrawtransaction
		_createrawtransaction=$(eval "${createRawTransaction}")
		#RawTX builds the complete json from .result array
		RawTX=$(echo $_createrawtransaction | jq '.result')
		echo $RawTX

		rpc_signrawtransaction "$RawTX"
		_signrawtransaction=$(eval "${signRawTransaction}")
		RawSIGN=$(echo $_signrawtransaction | jq '.result.hex')
		echo $RawSIGN

		rpc_sendrawtransaction "$RawSIGN"
		_sendrawtransaction=$(eval "${sendRawTransaction}")
		echo $_sendrawtransaction
		RawSEND=$(echo $_sendrawtransaction | jq '.result')
		echo $RawSEND
		echo "combined dust minus fee: "$subtractfee
		#sleep 5
           fi
       fi
done <<< "$unspentaddresses"
