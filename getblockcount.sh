#!/bin/bash
. config.conf
getblockcount=$(curl --silent --data-binary '{"jsonrpc":"1.0","id":"curltext","method":"getblockcount","params":[]}' -H 'content-type:text/plain;' http://$rpcusername:$rpcpassword@$rpchost:$rpcport/ | jq -r '.result')
echo $getblockcount
