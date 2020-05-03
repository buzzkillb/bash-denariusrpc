#!/bin/bash
. config.conf
. rpc.sh

#You want to change the wallet address in 3 spots to your address. Then change the first limit(100 to your # of inputs to clean 
#and then limit(200 to double the inputs amount. I am done with this, someone else can create variables and do more math. Can then
#put this in a while loop to clean up a million inputs. Adjust txfee to 0.00010000 and try 50 inputs as a test.

txfee=0.00020001

password=WALLETPASS
timeout=600
stakingonly=false

rpc_walletpassphrase "$password" "$timeout" "$stakingonly"
_walletpassphrase=$(eval "${walletPassPhrase}")


#functions used: rpc_listunspent rpc_createrawtransaction rpc_signrawtransaction rpc_sendrawtransaction
while true; do

rm raw.txt
sumnolimits=$(rpc_listunspent | jq --arg INPUTS "inputs"  '[limit(100;.[] | select(.address== "DGTdrgCX6jk1AsHvhMdDQx9r47Dey2xXii") | .amount | tonumber)] | .[] ' | jq -s add |  awk {' printf "%.8f",$1'})
echo "denarii dust: $sumnolimits"
subtractfee=$(echo "$sumnolimits - $txfee" | bc)

rpc_listunspent | jq --arg ADDRESS "$REPLY" '[limit(200;.[] | select(.address=="DGTdrgCX6jk1AsHvhMdDQx9r47Dey2xXii") | .txid,.vout )] | .[]' | (
		    while read txid; do
		        read vout
		        echo '{"txid":'$txid',"vout":'$vout'},' | tr -d ' \t\n\r\f' >> raw.txt
		    done
		)
sed -i '1s/^/'$QUOTE''$QUOTE'[/' raw.txt
sed -i '$ s/,$//g' raw.txt
echo ']'$QUOTE''$QUOTE', '$QUOTE''$QUOTE'{"DGTdrgCX6jk1AsHvhMdDQx9r47Dey2xXii":'$subtractfee'}'$QUOTE''$QUOTE'' | tr -d ' \t\n\r\f' >> raw.txt

#unlock wallet
rpc_walletpassphrase "$password" "$timeout" "$stakingonly"
_walletpassphrase=$(eval "${walletPassPhrase}")
#store rawtransaction
startrawtransaction=$(head -1 raw.txt)
#unlock wallet
rpc_walletpassphrase "$password" "$timeout" "$stakingonly"
_walletpassphrase=$(eval "${walletPassPhrase}")

#put startrawtransaction json into curl function command
rpc_createrawtransaction "${startrawtransaction}"
#bring full curl rpc string into _createrawtransaction
_createrawtransaction=$(eval "${createRawTransaction}")
#RawTX builds the complete json from .result array
RawTX=$(echo $_createrawtransaction | jq '.result')
echo $RawTX

#unlock wallet
rpc_walletpassphrase "$password" "$timeout" "$stakingonly"
_walletpassphrase=$(eval "${walletPassPhrase}")

rpc_signrawtransaction "$RawTX"
_signrawtransaction=$(eval "${signRawTransaction}")
RawSIGN=$(echo $_signrawtransaction | jq '.result.hex')
echo $RawSIGN

#unlock wallet
rpc_walletpassphrase "$password" "$timeout" "$stakingonly"
_walletpassphrase=$(eval "${walletPassPhrase}")

rpc_sendrawtransaction "$RawSIGN"
_sendrawtransaction=$(eval "${sendRawTransaction}")

echo $_sendrawtransaction
RawSEND=$(echo $_sendrawtransaction | jq '.result')
echo $RawSEND
echo "combined dust minus fee: "$subtractfee
done
