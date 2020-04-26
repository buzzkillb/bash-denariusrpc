#!/bin/bash
. config.conf
. rpc.sh

#Example
#shutdown wallet and message your wallet on another computer "shutting down wallet"
#first do a test send message to where you message to have the pubkey setup
#console: smsgsend PUBKEY
#replace password, smsgsendFrom, smsgsendTo, smsgsendMessage variables

password=PASSWORD
timeout=600
stakingonly=false

#unlock wallet to send message
rpc_walletpassphrase "$password" "$timeout" "$stakingonly"
_walletpassphrase=$(eval "${walletPassPhrase}")
printf '%s\n' "${_walletpassphrase}"
printf "Wallet unlocked\n"

#send message
smsgsendFrom=SENDFROMADDRESS
smsgsendTo=SENDTOADDRESS
smsgsendMessage="shutting down wallet"
sleep 2
rpc_smsgsend "$smsgsendFrom" "$smsgsendTo" "$smsgsendMessage"
_smsgsend=$(eval "${smsgSend}")

printf '%s\n' "${_smsgsend}" | jq -r '.result'

#shutdown wallet
sleep 5
stop_message=$(rpc_stop)
echo $stop_message
