# bash-denariusrpc
Bash Denarius RPC

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
### examples/dedust.sh
```
does not work on a password encrypted wallet yet
everything in same folder somewhere on your PC
wget https://raw.githubusercontent.com/buzzkillb/bash-denariusrpc/master/config.conf.template
cp config.conf.template config.conf
edit to your RPC settings
get the rpc.sh with functions
https://raw.githubusercontent.com/buzzkillb/bash-denariusrpc/master/rpc.sh
get dedust.sh
wget https://raw.githubusercontent.com/buzzkillb/bash-denariusrpc/master/examples/dedust.sh
sudo apt install jq bc
chmod +x rpc.sh
chmod +x dedust.sh
modify settings in dedust.sh for your coin settings (txfee!!!!)
./dedust.sh
output:
cleaned up wallet
```  
![Denarius](https://github.com/buzzkillb/D-explorer/blob/master/public/images/denarius.gif)
