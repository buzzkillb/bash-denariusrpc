#!/bin/bash
. config.conf
. rpc.sh
password=WALLETPASS
timeout=600
stakingonly=true
rpc_walletpassphrase "$password" "$timeout" "$stakingonly"
_walletpassphrase=$(eval "${walletPassPhrase}")
printf '%s\n' "${_walletpassphrase}"
printf "Wallet unlocked\n"
