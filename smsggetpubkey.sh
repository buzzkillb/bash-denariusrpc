#!/bin/bash
. config.conf
. rpc.sh

#uses functions: rpc_smsggetpubkey

#options: input address in your own wallet, doesn't need a send/receive of coins
smsgGetPubKey=D6jievtTm6SxFPpywDa7yaAJAYMBrqh8Te

rpc_smsggetpubkey "$smsgGetPubKey"
_smsggetpubkey=$(eval "${smsgGetpubkey}")

printf '%s\n' "${_smsggetpubkey}" | jq -r '.result'
printf '%s\n' "${_smsggetpubkey}" | jq -r '."address in wallet"'
printf '%s\n' "${_smsggetpubkey}" | jq -r '."compressed public key"'

#store public key in compressedpublickey
compressedpublickey=$(eval "${smsgGetpubkey}" | jq -r '."compressed public key"')
echo $compressedpublickey
