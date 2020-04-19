#!/bin/bash
. config.conf
listunspent=$(curl --silent --data-binary '{"jsonrpc":"1.0","id":"curltext","method":"listunspent","params":[]}' -H 'content-type:text/plain;' http://$rpcusername:$rpcpassword@$rpchost:$rpcport/ | jq -r '.result')
echo "$listunspent"
