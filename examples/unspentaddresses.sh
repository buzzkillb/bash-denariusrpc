#!/bin/bash
unspentaddresses=$(./listunspent.sh | jq -r '.[].address' | awk '!seen[$0]++')
echo "$unspentaddresses"
