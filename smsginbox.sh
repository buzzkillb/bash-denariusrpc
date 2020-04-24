#!/bin/bash
. config.conf
. rpc.sh

#uses functions: rpc_smsginbox

#options: all unread clear
smsgInboxCheck=unread

rpc_smsginbox "$smsgInboxCheck"
_smsginbox=$(eval "${smsgInbox}")
printf '%s\n' "${_smsginbox}" | jq -r '.message.received'
printf '%s\n' "${_smsginbox}" | jq -r '.message.sent'
printf '%s\n' "${_smsginbox}" | jq -r '.message.from'
printf '%s\n' "${_smsginbox}" | jq -r '.message.to'
printf '%s\n' "${_smsginbox}" | jq -r '.message.text'
