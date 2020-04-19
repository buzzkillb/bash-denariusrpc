#!/bin/bash
. config.conf
. rpc.sh
version=$(echo $(rpc_get_info) | jq -r '.version')
protocolversion=$(echo $(rpc_get_info) | jq -r '.protocolversion')
printf 'version: %s\n' "${version}"
printf 'protocolversion: %s\n' "${protocolversion}"
