#!/bin/bash
. config.conf
. rpc.sh

#uses functions: rpc_getblock

bestBlockHash=0000000003a0cc128a92e04b2c30637291e607739337bd6384723a58cad73327

rpc_getblock "$bestBlockHash"
_getblock=$(eval "${getBlock}")
echo $_getblock | jq '.'

#get coinbase
coinbase=$(echo $_getblock | jq -r '.tx[].vin[].coinbase')
printf 'coinbase: %s\n' "${coinbase}"

#convert coinbase hex to ascii
convertasciitohex=$(echo $coinbase | xxd -r -p)
printf "${convertasciitohex}"
