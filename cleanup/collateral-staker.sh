#stake 5000 FortunaStake collateral, send to new address, and reload.

#todo: add unlocking wallet per step, still testing automation part

#!/bin/bash
#Denarius 5000 FortunaStake Collateral Staker
. config.conf
. rpc.sh

#daemon location
denariusdaemon=denarius.daemon
#debug.log location
debuglog=~/snap/denarius/common/.denarius/debug.log

#FUNCTIONS
#
# Show a progress bar for $1 seconds
#
# Copyleft 2017 by Ignacio Nunez Hernanz <nacho _a_t_ ownyourbits _d_o_t_ com>
# GPL licensed (see end of file) * Use at your own risk!
#
# Example: progress_bar 60
#

progress_bar()
{
  local DURATION=$1
  local INT=0.25      # refresh interval

  local TIME=0
  local CURLEN=0
  local SECS=0
  local FRACTION=0

  local FB=2588       # full block

  trap "echo -e $(tput cnorm); trap - SIGINT; return" SIGINT

  echo -ne "$(tput civis)\r$(tput el)│"                # clean line

  local START=$( date +%s%N )

  while [ $SECS -lt $DURATION ]; do
    local COLS=$( tput cols )

    # main bar
    local L=$( bc -l <<< "( ( $COLS - 5 ) * $TIME  ) / ($DURATION-$INT)" | awk '{ printf "%f", $0 }' )
    local N=$( bc -l <<< $L                                              | awk '{ printf "%d", $0 }' )

    [ $FRACTION -ne 0 ] && echo -ne "$( tput cub 1 )"  # erase partial block

    if [ $N -gt $CURLEN ]; then
      for i in $( seq 1 $(( N - CURLEN )) ); do
        echo -ne \\u$FB
      done
      CURLEN=$N
    fi

    # partial block adjustment
    FRACTION=$( bc -l <<< "( $L - $N ) * 8" | awk '{ printf "%.0f", $0 }' )

    if [ $FRACTION -ne 0 ]; then 
      local PB=$( printf %x $(( 0x258F - FRACTION + 1 )) )
      echo -ne \\u$PB
    fi

    # percentage progress
    local PROGRESS=$( bc -l <<< "( 100 * $TIME ) / ($DURATION-$INT)" | awk '{ printf "%.0f", $0 }' )
    echo -ne "$( tput sc )"                            # save pos
    echo -ne "\r$( tput cuf $(( COLS - 6 )) )"         # move cur
    echo -ne "│ $PROGRESS%"
    echo -ne "$( tput rc )"                            # restore pos

    TIME=$( bc -l <<< "$TIME + $INT" | awk '{ printf "%f", $0 }' )
    SECS=$( bc -l <<<  $TIME         | awk '{ printf "%d", $0 }' )

    # take into account loop execution time
    local END=$( date +%s%N )
    local DELTA=$( bc -l <<< "$INT - ( $END - $START )/1000000000" \
                   | awk '{ if ( $0 > 0 ) printf "%f", $0; else print "0" }' )
    sleep $DELTA
    START=$( date +%s%N )
  done

  echo $(tput cnorm)
  trap - SIGINT
}

while true; do

#read first line into separate variables
#FS_FULL_LINE=$(awk 'NR==1' fortunastake.conf)
FS_ALIAS=$(awk '{if(NR==1) print $1}' fortunastake.conf)
FS_IP_ADDRESS=$(awk '{if(NR==1) print $2}' fortunastake.conf)
FS_GENKEY=$(awk '{if(NR==1) print $3}' fortunastake.conf)
FS_TX=$(awk '{if(NR==1) print $4}' fortunastake.conf)
FS_INDEX=$(awk '{if(NR==1) print $5}' fortunastake.conf)
#echo entire line so we see it
printf "${FS_ALIAS} ${FS_IP_ADDRESS} ${FS_GENKEY} ${FS_TX} ${FS_INDEX}\n"

sleep 1
#remove first line to move to bottom of fortunastake.conf
printf "Removing first line above from fortunastake.conf\n"
sed -i '1d' fortunastake.conf

#restart wallet to stake 5000 Denarius Coins
#stop daemon using rpc, 60 seconds to fully stop
printf "Stopping Daemon - 90 seconds\n"
sleep 1
rpc_stop
progress_bar 90
#start daemon and force staking=1 flag, 90 seconds to fully start
printf "Starting Daemon - 90 seconds\n"
$denariusdaemon -staking=1
progress_bar 120

#Lets just wait so many confirms instead of a timer
#sleep 10min waiting for stake
#printf "Wait not sure here yet 300 sec, 5  min for stake\n"
#progress_bar 300

#then wait 85 extra confirms so stake is fully confirmed and no reorgs
#get blockheight
stakeheight=$(rpc_get_blockcount)
printf "Stake Height: ${stakeheight} - Wait 85 confirms\n"
stakeconfirms=85
heighttoconfirm=$((stakeheight+stakeconfirms))
printf "Full Confirmed: $heighttoconfirm\n"
tail -f $debuglog | egrep -m 1 "$heighttoconfirm  trust="
printf "Found Height ${heighttoconfirm}. Time to send collateral\n"

#Prepare 5000 Denarius coins to send to getnewaddress
printf "Get New Address\n"
getnewaddress_alias=$FS_ALIAS
rpc_get_newaddress "$getnewaddress_alias"
_getnewaddress=$(eval "${getNewAddress}")
printf "Send 5000 D to ${_getnewaddress}\n"

#Amount to send, should be 5000 exactly
sendTo=${_getnewaddress}
sendAmount=5000
sendComment="$FS_ALIAS"

#send 5000 Denarius and grab TXID
rpc_sendtoaddress "$sendTo" "$sendAmount" "$sendComment"
FS_TX_NEW=$(eval "${sendToAddress}")
printf "TXID: ${FS_TX_NEW}\n"

#store transaction in $_gettransaction variable
transaction=${FS_TX_NEW}
rpc_get_transaction "$transaction"
_gettransaction=$(eval "${getTransaction}")

#Search transaction json for address we just sent to and grab the index number
FS_INDEX_NEW=$(echo $_gettransaction | jq -r --arg ADDRESS "$_getnewaddress" '.vout[] | select(.scriptPubKey.addresses[]==$ADDRESS) | .n')
printf "Index: ${FS_INDEX_NEW}\n"

#echo new full line going into fortunastake.conf
printf "${FS_ALIAS} ${FS_IP_ADDRESS} ${FS_GENKEY} ${FS_TX_NEW} ${FS_INDEX_NEW}\n"
#put full new LINE at bottom of fortunastake.conf
echo "${FS_ALIAS}" "${FS_IP_ADDRESS}" "${FS_GENKEY}" "${FS_TX_NEW}" "${FS_INDEX_NEW}" >> fortunastake.conf
printf "Wait 240 seconds for send to go through\n"
progress_bar 240
#restart wallet to set lock new FortunaStake
#stop daemon using rpc, 60 seconds to fully stop
printf "Stopping Daemon - 90 seconds\n"
sleep 1
rpc_stop
progress_bar 90
#start daemon and force staking=1 flag, 90 seconds to fully start
printf "Starting Daemon - 90 seconds\n"
$denariusdaemon -staking=1
progress_bar 90

rpc_masternode_status
_masternodestatus=$(eval ${masternodeStatus} | jq -r '.[] | select(.status=="notfound") | .alias,.status ') 
printf '%s\n' "${_masternodestatus}" | (
    while read alias; do
        read status
        echo 'alias:' $alias
        echo 'status:' $status
        rpc_masternode_startalias "$alias"
	_masternodestartalias=$(eval "${masternodeStartAlias}")
	printf '%s\n' "${_masternodestartalias}"
    done
)


printf "Can stop here - 60 seconds\n"
sleep 60

done
