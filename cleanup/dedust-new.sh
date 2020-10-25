#combine inputs and send to a given address, around line 51
#!/bin/bash
. config.conf
. rpc.sh

txfee=0.00010001
minimuminputs=0
minimumbalance=0.0010000
zeroRewards=0.00000000
maximumInput=1.00000000

#functions used: rpc_listunspent rpc_createrawtransaction rpc_signrawtransaction rpc_sendrawtransaction

#deduplicate addresses
unspentaddresses=$(rpc_listunspent | jq -r '.[].address' | awk '!seen[$0]++')
while IFS= read -r
do
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
		echo ']'$QUOTE''$QUOTE', '$QUOTE''$QUOTE'{"DQZSjuk6R9gJpsW7ruiAoFWxL3MFxMp":'$subtractfee'}'$QUOTE''$QUOTE'' | tr -d ' \t\n\r\f' >> raw.txt
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
           fi
       fi
done <<< "$unspentaddresses"
