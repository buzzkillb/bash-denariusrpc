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
### examples/dedust.sh
```
everything in same folder somewhere on your PC
wget https://raw.githubusercontent.com/buzzkillb/bash-denariusrpc/master/config.conf.template
cp config.conf.template config.conf
edit to your RPC settings
wget https://raw.githubusercontent.com/buzzkillb/bash-denariusrpc/master/examples/dedust.sh
wget https://raw.githubusercontent.com/buzzkillb/bash-denariusrpc/master/listunspent.sh
sudo apt install jq
chmod +x listunspent.sh
chmod +x dedust.sh
modify settings in dedust.sh for your coin settings (txfee!!!!)
./dedust.sh
output:
cleaned up wallet
```
![Denarius](/public/images/denarius.gif)
