#!/bin/bash
. config.conf
. rpc.sh

#functions used: rpc_masternode_status, rpc_masternode_startalias

rpc_masternode_status
_masternodestatus=$(eval ${masternodeStatus} | jq -r '.[] | select(.status=="notfound") | .alias,.status ') 
printf '%s\n' "${_masternodestatus}" | (
    while read alias; do
        read status
        echo 'alias:' $alias
        echo 'status:' $status
        rpc_masternode_startalias "$alias"
	_masternodestartalias=$(eval "${masternodeStartAlias}")
	printf '%s\n' "${_masternodestartalias}"
    done
)
