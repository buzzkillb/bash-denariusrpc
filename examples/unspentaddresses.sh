#!/bin/bash
. config.conf
. rpc.sh
unspentaddresses=$(rpc_listunspent | jq -r '.[].address' | awk '!seen[$0]++')
printf '%s\n' "${unspentaddresses}"
