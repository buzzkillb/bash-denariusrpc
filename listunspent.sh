#!/bin/bash
. config.conf
. rpc.sh
listunspent=$(rpc_listunspent | jq -r '.[]')
printf '%s\n' "${listunspent}"
