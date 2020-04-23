#!/bin/bash
. config.conf
. rpc.sh

#uses functions: rpc_jupiter_upload
uploadfile=/home/user/denarius.txt

rpc_jupiter_upload "${uploadfile}"
_jupiterupload=$(eval ${jupiterUpload})

printf '%s\n' "${_jupiterupload}" | jq -r '.filename'
printf '%s\n' "${_jupiterupload}" | jq -r '.sizebytes'
printf '%s\n' "${_jupiterupload}" | jq -r '.ipfshash'
printf '%s\n' "${_jupiterupload}" | jq -r '.infuralink'
printf '%s\n' "${_jupiterupload}" | jq -r '.cflink'
printf '%s\n' "${_jupiterupload}" | jq -r '.ipfslink'
