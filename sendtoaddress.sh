#!/bin/bash
. config.conf
. rpc.sh

#uses functions: rpc_sendtoaddress

sendTo=DDW5FAPkqCHACxoynKmVzpVjcnXN7kW5GT
sendAmount=0.000001
sendComment="test message"

rpc_sendtoaddress "$sendTo" "$sendAmount" "$sendComment"
_sendtoaddress=$(eval "${sendToAddress}")
echo $_sendtoaddress
