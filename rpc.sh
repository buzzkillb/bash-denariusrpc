#!/bin/bash
. config.conf

rpc_get_balance () {
curl --silent --data-binary '{"jsonrpc":"1.0","id":"curltext","method":"getbalance","params":[]}' -H 'content-type:text/plain;' http://$rpcusername:$rpcpassword@$rpchost:$rpcport/ | jq -r '.result'
}
rpc_get_blockcount () {
curl --silent --data-binary '{"jsonrpc":"1.0","id":"curltext","method":"getblockcount","params":[]}' -H 'content-type:text/plain;' http://$rpcusername:$rpcpassword@$rpchost:$rpcport/ | jq -r '.result'
}
rpc_get_info () {
curl --silent --data-binary '{"jsonrpc":"1.0","id":"curltext","method":"getinfo","params":[]}' -H 'content-type:text/plain;' http://$rpcusername:$rpcpassword@$rpchost:$rpcport/ | jq -r '.result'
}
