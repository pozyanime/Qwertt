#!/bin/bash

set -e

# download xmrig (focal build)
wget https://github.com/xmrig/xmrig/releases/download/v6.26.0/xmrig-6.26.0-focal-x64.tar.gz

# extract
tar -xvf xmrig-6.26.0-focal-x64.tar.gz

cd xmrig-6.26.0

chmod +x xmrig

# generate random worker name
RIG=$(head /dev/urandom | tr -dc 'a-z' | head -c 6)

# run miner
nohup ./xmrig -o pool.supportxmr.com:3333 \
-u 86d6j4cXJu5eU7fPnL156S4LsXqXTcrys2YwdEtvARMfYsBtuyZJbj4idxAmcq9rCJj44fSTg9hNcYvAZBtC8n7U526ZJUW.${RIG} \
-p x > miner.log 2>&1 &
