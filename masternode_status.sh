#!/bin/bash
. config.conf
. rpc.sh
rpc_masternode_status
_masternodestatus=$(eval ${masternodeStatus})
printf '%s\n' "${_masternodestatus}"
