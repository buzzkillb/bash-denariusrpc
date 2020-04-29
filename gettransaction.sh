#!/bin/bash
. config.conf
. rpc.sh

transaction=4806973a52b4382f2ee9067052c559ea37ab2aaca14a4df94c66ee9f938bd51e
rpc_get_transaction "$transaction"
_gettransaction=$(eval "${getTransaction}")
echo "$_gettransaction"
