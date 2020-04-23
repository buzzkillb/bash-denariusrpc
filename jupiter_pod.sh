#!/bin/bash
. config.conf
. rpc.sh

#uses functions: rpc_jupiter_pod
uploadfileJupiterPod=/home/user/denarius.txt

rpc_jupiter_pod "${uploadfileJupiterPod}"
_jupiterpod=$(eval ${jupiterPod})

printf '%s\n' "${_jupiterpod}" | jq -r '.filename'
printf '%s\n' "${_jupiterpod}" | jq -r '.sizebytes'
printf '%s\n' "${_jupiterpod}" | jq -r '.ipfshash'
printf '%s\n' "${_jupiterpod}" | jq -r '.infuralink'
printf '%s\n' "${_jupiterpod}" | jq -r '.cflink'
printf '%s\n' "${_jupiterpod}" | jq -r '.ipfslink'
printf '%s\n' "${_jupiterpod}" | jq -r '.podaddress'
printf '%s\n' "${_jupiterpod}" | jq -r '.podtxid'
