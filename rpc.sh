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
rpc_get_newaddress () {
getNewAddress="curl -s -d '{\"jsonrpc\":\"1.0\",\"id\":\"curltext\",\"method\":\"getnewaddress\",\"params\":[\""${1}"\"]}' -H 'content-type:text/plain;' http://"${rpcusername}":"${rpcpassword}"@"${rpchost}":"${rpcport}" | jq -r '.result'"
local getNewAddress
}
rpc_get_peerinfo () {
curl -s -d '{"jsonrpc":"1.0","id":"curltext","method":"getpeerinfo","params":[]}' -H 'content-type:text/plain;' http://"${rpcusername}":"${rpcpassword}"@"${rpchost}":"${rpcport}"/ | jq -r '.result'
}
rpc_get_transaction () {
getTransaction="curl -s -d '{\"jsonrpc\":\"1.0\",\"id\":\"curltext\",\"method\":\"gettransaction\",\"params\":[\""${1}"\"]}' -H 'content-type:text/plain;' http://"${rpcusername}":"${rpcpassword}"@"${rpchost}":"${rpcport}" | jq -r '.result'"
local getTransaction
}
rpc_listunspent () {
curl -s -d '{"jsonrpc":"1.0","id":"curltext","method":"listunspent","params":[]}' -H 'content-type:text/plain;' http://"${rpcusername}":"${rpcpassword}"@"${rpchost}":"${rpcport}"/ | jq -r '.result'
}
rpc_proofofdata () {
proofofData="curl -s -d '{\"jsonrpc\":\"1.0\",\"id\":\"curltext\",\"method\":\"proofofdata\",\"params\":[\""${1}"\"]}}' -H 'content-type:text/plain;' http://"${rpcusername}":"${rpcpassword}"@"${rpchost}":"${rpcport}"/ | jq -r '.result'"
local proofofData
}
rpc_sendtoaddress () {
sendToAddress="curl -s -d '{\"jsonrpc\":\"1.0\",\"id\":\"curltext\",\"method\":\"sendtoaddress\",\"params\":[\""${1}"\", "${2}", \""${3}"\"]}' -H 'content-type:text/plain;' http://"${rpcusername}":"${rpcpassword}"@"${rpchost}":"${rpcport}"/ | jq -r '.result'"
local sendToAddress
}
rpc_stop () {
curl -s -d '{"jsonrpc":"1.0","id":"curltext","method":"stop","params":[]}' -H 'content-type:text/plain;' http://"${rpcusername}":"${rpcpassword}"@"${rpchost}":"${rpcport}"/ | jq -r '.result'
}
rpc_walletpassphrase () {
walletPassPhrase="curl -s -d '{\"jsonrpc\":\"1.0\",\"id\":\"curltext\",\"method\":\"walletpassphrase\",\"params\":[\""${1}"\", "${2}", "${3}"]}' -H 'content-type:text/plain;' http://"${rpcusername}":"${rpcpassword}"@"${rpchost}":"${rpcport}" | jq -r '.error.message'"
local walletPassPhrase
}
rpc_createrawtransaction () {
createRawTransaction="curl -s -d '{\"jsonrpc\":\"1.0\",\"id\":\"curltext\",\"method\":\"createrawtransaction\",\"params\":["${1}"]}' -H 'content-type:text/plain;' http://"${rpcusername}":"${rpcpassword}"@"${rpchost}":"${rpcport}"/"
local createRawTransaction
}
rpc_signrawtransaction () {
signRawTransaction="curl -s -d '{\"jsonrpc\":\"1.0\",\"id\":\"curltext\",\"method\":\"signrawtransaction\",\"params\":["${1}"]}' -H 'content-type:text/plain;' http://"${rpcusername}":"${rpcpassword}"@"${rpchost}":"${rpcport}"/"
local signRawTransaction
}
rpc_sendrawtransaction () {
sendRawTransaction="curl -s -d '{\"jsonrpc\":\"1.0\",\"id\":\"curltext\",\"method\":\"sendrawtransaction\",\"params\":["${1}"]}' -H 'content-type:text/plain;' http://"${rpcusername}":"${rpcpassword}"@"${rpchost}":"${rpcport}"/"
local sendRawTransaction
}
rpc_masternode_status () {
masternodeStatus="curl -s -d '{\"jsonrpc\":\"1.0\",\"id\":\"curltext\",\"method\":\"masternode\",\"params\":[\"status\"]}' -H 'content-type:text/plain;' http://"${rpcusername}":"${rpcpassword}"@"${rpchost}":"${rpcport}"/ | jq -r '.result'"
local masternodeStatus
}
rpc_masternode_startalias () {
masternodeStartAlias="curl -s -d '{\"jsonrpc\":\"1.0\",\"id\":\"curltext\",\"method\":\"masternode\",\"params\":[\"start-alias\", \""${1}"\"]}' -H 'content-type:text/plain;' http://"${rpcusername}":"${rpcpassword}"@"${rpchost}":"${rpcport}"/ | jq -r '.result'"
local masternodeStartAlias
}
rpc_jupiterversion () {
jupiterVersion="curl -s -d '{\"jsonrpc\":\"1.0\",\"id\":\"curltext\",\"method\":\"jupiterversion\",\"params\":[]}' -H 'content-type:text/plain;' http://"${rpcusername}":"${rpcpassword}"@"${rpchost}":"${rpcport}"/ | jq -r '.result'"
local jupiterVersion
}
rpc_jupiter_upload () {
jupiterUpload="curl -s -d '{\"jsonrpc\":\"1.0\",\"id\":\"curltext\",\"method\":\"jupiterupload\",\"params\":[\""${1}"\"]}}' -H 'content-type:text/plain;' http://"${rpcusername}":"${rpcpassword}"@"${rpchost}":"${rpcport}"/ | jq -r '.result'"
local jupiterUpload
}
rpc_jupiter_pod () {
jupiterPod="curl -s -d '{\"jsonrpc\":\"1.0\",\"id\":\"curltext\",\"method\":\"jupiterpod\",\"params\":[\""${1}"\"]}}' -H 'content-type:text/plain;' http://"${rpcusername}":"${rpcpassword}"@"${rpchost}":"${rpcport}"/ | jq -r '.result'"
local jupiterPod
}
rpc_smsggetpubkey () {
smsgGetpubkey="curl -s -d '{\"jsonrpc\":\"1.0\",\"id\":\"curltext\",\"method\":\"smsggetpubkey\",\"params\":[\""${1}"\"]}' -H 'content-type:text/plain;' http://"${rpcusername}":"${rpcpassword}"@"${rpchost}":"${rpcport}" | jq -r '.result'"
local smsgGetpubkey
}
rpc_smsgsend () {
smsgSend="curl -s -d '{\"jsonrpc\":\"1.0\",\"id\":\"curltext\",\"method\":\"smsgsend\",\"params\":[\""${1}"\", \""${2}"\", \""${3}"\"]}' -H 'content-type:text/plain;' http://"${rpcusername}":"${rpcpassword}"@"${rpchost}":"${rpcport}" | jq -r '.result'"
local smsgSend
}
rpc_smsginbox () {
smsgInbox="curl -s -d '{\"jsonrpc\":\"1.0\",\"id\":\"curltext\",\"method\":\"smsginbox\",\"params\":[\""${1}"\"]}' -H 'content-type:text/plain;' http://"${rpcusername}":"${rpcpassword}"@"${rpchost}":"${rpcport}" | jq -r '.result'"
local smsgInbox
}
