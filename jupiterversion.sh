#!/bin/bash
. config.conf
. rpc.sh

#uses functions: rpc_jupiterversion

rpc_jupiterversion
_jupiterversion=$(eval ${jupiterVersion})
printf '%s\n' "${_jupiterversion}" | jq -r '.connected'
printf '%s\n' "${_jupiterversion}" | jq -r '.jupiterlocal'
printf '%s\n' "${_jupiterversion}" | jq -r '.ipfspeer'
printf '%s\n' "${_jupiterversion}" | jq -r '.ipfsversion'
