#!/bin/bash
. config.conf
. rpc.sh

txfee=0.00010001
minimuminputs=1
minimumbalance=0.00100000

#functions used: rpc_listunspent

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
		rpc_listunspent | jq --arg ADDRESS "$REPLY" '.[] | select(.address==$ADDRESS) | .txid,.vout ' |  (
		    while read txid; do
		        read vout
		        echo '{"txid":'$txid',"vout":'$vout'},' | tr -d ' \t\n\r\f' >> raw.txt
		    done
		)
                QUOTE="'"
                sed -i '1s/^/'$QUOTE''$QUOTE'[/' raw.txt
		sed -i '$ s/,$//g' raw.txt
		echo ']'$QUOTE''$QUOTE', '$QUOTE''$QUOTE'{"'$REPLY'":'$subtractfee'}'$QUOTE''$QUOTE'' | tr -d ' \t\n\r\f' >> raw.txt
		#store rawtransaction
        	startrawtransaction=$(head -1 raw.txt)
                createrawtransaction="curl --silent -d '{\"jsonrpc\":\"1.0\",\"id\":\"curltext\",\"method\":\"createrawtransaction\",\"params\":["$startrawtransaction"]}' -H 'content-type:text/plain;' http://"$rpcusername":"$rpcpassword"@"$rpchost":"$rpcport"/"
        	createRawTransaction=$(eval "$createrawtransaction")
        	RawTX=$(echo $createRawTransaction | jq '.result')
        	signrawtransaction="curl --silent -d '{\"jsonrpc\":\"1.0\",\"id\":\"curltext\",\"method\":\"signrawtransaction\",\"params\":["$RawTX"]}' -H 'content-type:text/plain;' http://"$rpcusername":"$rpcpassword"@"$rpchost":"$rpcport"/"
        	signRawTransaction=$(eval "$signrawtransaction")
        	RawSIGN=$(echo $signRawTransaction | jq '.result.hex')
        	echo $RawSIGN
        	sendrawtransaction="curl --silent -d '{\"jsonrpc\":\"1.0\",\"id\":\"curltext\",\"method\":\"sendrawtransaction\",\"params\":["$RawSIGN"]}' -H 'content-type:text/plain;' http://"$rpcusername":"$rpcpassword"@"$rpchost":"$rpcport"/"
        	sendRawTransaction=$(eval "$sendrawtransaction")
        	RawSEND=$(echo $sendRawTransaction)
        	echo $RawSEND
		echo "combined dust minus fee: "$subtractfee
           fi
       fi
done <<< "$unspentaddresses"
