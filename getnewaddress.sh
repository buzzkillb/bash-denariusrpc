#!/bin/bash
. config.conf
. rpc.sh
getnewaddress_alias=DENARIUS_ROCKS
rpc_get_newaddress "$getnewaddress_alias"
_getnewaddress=$(eval "${getNewAddress}")
printf '%s\n' "${_getnewaddress}"
