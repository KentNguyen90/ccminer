#!/bin/bash
device_name=$(getprop ro.product.model)
echo "Setup CCminer for RIG NAME: $device_name"
yes | pkg update && pkg upgrade
yes | pkg install libjansson build-essential clang binutils git libcurl4-openssl-dev libjansson-dev libomp-dev screen nano jq wget
cp /data/data/com.termux/files/usr/include/linux/sysctl.h /data/data/com.termux/files/usr/include/sys
wget http://ports.ubuntu.com/pool/main/o/openssl/libssl1.1_1.1.0g-2ubuntu4_arm64.deb
sudo dpkg -i libssl1.1_1.1.0g-2ubuntu4_arm64.deb
rm libssl1.1_1.1.0g-2ubuntu4_arm64.deb
git clone https://github.com/kentNguyen90/ccminer.git
cd ccminer
EOF
chmod +x build.sh configure.sh autogen.sh start.sh
if [ ! -f ~/.bashrc ]; then
  echo "~/ccminer/start.sh" > ~/.bashrc
else
  if ! grep -Fxq "~/ccminer/start.sh" ~/.bashrc; then
    echo "~/ccminer/start.sh" >> ~/.bashrc
  fi
fi
CXX=clang++ CC=clang ./build.sh
echo "config.json was updated."
echo "setup nearly complete."
echo "Edit the config with \"nano ~/ccminer/config.json\""
echo "start the miner with \"cd ~/ccminer; ./start.sh\"."