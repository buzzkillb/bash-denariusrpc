#!/bin/bash
. config.conf
. rpc.sh

#uses functions: rpc_smsgsend

smsgsendFrom=D5AUr4VbX2J3w6oAGvcoBYJSJWHMrqgkkn
smsgsendTo=D5CQ4a3dxocieTn8fUMowFhjzGFA6VZuUV
smsgsendMessage="test message"

rpc_smsgsend "$smsgsendFrom" "$smsgsendTo" "$smsgsendMessage"
_smsgsend=$(eval "${smsgSend}")

printf '%s\n' "${_smsgsend}" | jq -r '.result'
