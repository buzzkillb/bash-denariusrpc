#!/bin/bash
. config.conf
. rpc.sh

peers=$(rpc_get_peerinfo | jq -r '.')

printf '%s\n' "${peers}"
