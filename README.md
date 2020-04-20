# bash-denariusrpc
Bash Denarius RPC

### denarius.conf (or yourcoin.conf in appdata directory) requires 
```
rpcusername=RPCUSERNAME
rpcpassword=RPCPASSWORD
rpcport=32369
server=1
```

### getbalance.sh  
```
wget https://raw.githubusercontent.com/buzzkillb/bash-denariusrpc/master/config.conf.template
cp config.conf.template config.conf
edit to your RPC settings
wget https://raw.githubusercontent.com/buzzkillb/bash-denariusrpc/master/getbalance.sh
chmod +x getbalance.sh
./getbalance.sh
output:
Denarius Balance: 1.33701337
```
### examples/dedust_fun.sh
```
does not work on a password encrypted wallet yet
everything in same folder somewhere on your PC
wget https://raw.githubusercontent.com/buzzkillb/bash-denariusrpc/master/config.conf.template
cp config.conf.template config.conf
edit to your RPC settings
get the rpc.sh with functions
https://raw.githubusercontent.com/buzzkillb/bash-denariusrpc/master/rpc.sh
get dedust_fun.sh
https://raw.githubusercontent.com/buzzkillb/bash-denariusrpc/master/examples/dedust_fun.sh
sudo apt install jq bc
chmod +x rpc.sh
chmod +x dedust_fun.sh
modify settings in dedust_fun.sh for your coin settings (txfee!!!!)
./dedust_fun.sh
output:
cleaned up wallet
```  

###examples/masternode_monitor.sh
```
requires config.conf and rpc.sh
uses masternode RPC so should be changeable to specific coin's JSON
chmod +x masternode_monitor.sh
./masternode_monitor.sh
will restart any notfound masternodes on the collateral wallet
```
![Denarius](https://github.com/buzzkillb/D-explorer/blob/master/public/images/denarius.gif)
