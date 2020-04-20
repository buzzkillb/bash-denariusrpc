#!/bin/bash
. config.conf
. rpc.sh
masternode_alias=D01
rpc_masternode_startalias "$masternode_alias"
_masternodestartalias=$(eval "${masternodeStartAlias}")
printf '%s\n' "${_masternodestartalias}"
