# bash-denariusrpc
Bash Denarius RPC

### getbalance.sh  
```
cp config.conf.template config.conf
edit to your RPC settings
chmod +x getbalance.sh
./getbalance.sh
output:
Denarius Balance: 1.33701337
```
### dedust.sh
```
everything in same folder
cp config.conf.template config.conf
edit to your RPC settings
get listunspent.sh
sudo apt install jq
chmod +x listunspent.sh
chmod +x dedust.sh
modify settings in dedust.sh for your coin settings (txfee!!!!)
./dedust.sh
output:
cleaned up wallet
```
