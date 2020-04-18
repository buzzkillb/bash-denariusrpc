#!/bin/bash
coin=Denarius
rpcusername=RPCUSERNAME
rpcpassword=RPCPASSWORD
rpchost=127.0.0.1
rpcport=32369
listunspent=$(curl --silent --data-binary '{"jsonrpc":"1.0","id":"curltext","method":"listunspent","params":[]}' -H 'content-type:text/plain;' http://$rpcusername:$rpcpassword@$rpchost:$rpcport/ | jq -r '.result[]')
echo "$listunspent"
