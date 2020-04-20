#!/bin/bash
. config.conf
. rpc.sh

#uses functions: rpc_jupiterversion

connected=$(rpc_jupiterversion | jq -r '.connected')
jupiterlocal=$(rpc_jupiterversion | jq -r '.jupiterlocal')
ipfspeer=$(rpc_jupiterversion | jq -r '.ipfspeer')
ipfsversion=$(rpc_jupiterversion | jq -r '.ipfsversion')
printf 'connected: %s\n' "${connected}"
printf 'jupiterlocal: %s\n' "${jupiterlocal}"
printf 'ipfspeer: %s\n' "${ipfspeer}"
printf 'ipfsversion: %s\n' "${ipfsversion}"
