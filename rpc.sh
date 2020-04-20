#!/bin/bash
. config.conf

rpc_get_balance () {
curl -s -d '{"jsonrpc":"1.0","id":"curltext","method":"getbalance","params":[]}' -H 'content-type:text/plain;' http://"${rpcusername}":"${rpcpassword}"@"${rpchost}":"${rpcport}"/ | jq -r '.result'
}
rpc_get_blockcount () {
curl -s -d '{"jsonrpc":"1.0","id":"curltext","method":"getblockcount","params":[]}' -H 'content-type:text/plain;' http://"${rpcusername}":"${rpcpassword}"@"${rpchost}":"${rpcport}"/ | jq -r '.result'
}
rpc_get_info () {
curl -s -d '{"jsonrpc":"1.0","id":"curltext","method":"getinfo","params":[]}' -H 'content-type:text/plain;' http://"${rpcusername}":"${rpcpassword}"@"${rpchost}":"${rpcport}"/ | jq -r '.result'
}
rpc_listunspent () {
curl -s -d '{"jsonrpc":"1.0","id":"curltext","method":"listunspent","params":[]}' -H 'content-type:text/plain;' http://"${rpcusername}":"${rpcpassword}"@"${rpchost}":"${rpcport}"/ | jq -r '.result'
}
