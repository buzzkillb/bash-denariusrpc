#!/bin/bash
. config.conf
. rpc.sh

#uses functions: rpc_proofofdata
uploadfile=/home/user/denarius.txt

rpc_proofofdata "${uploadfile}"
_proofofdata=$(eval ${proofofData})

printf '%s\n' "${_proofofdata}" | jq -r '.filename'
printf '%s\n' "${_proofofdata}" | jq -r '.podaddress'
printf '%s\n' "${_proofofdata}" | jq -r '.podtxid'
