#!/bin/bash
device_name=$(getprop ro.product.model)
echo "Setup CCminer for RIG NAME: $device_name"

yes | pkg update && pkg upgrade
yes | pkg install libjansson build-essential clang binutils git
cp /data/data/com.termux/files/usr/include/linux/sysctl.h /data/data/com.termux/files/usr/include/sys
git clone https://github.com/KentNguyen90/ccminer.git
cd ccminer
chmod +x build.sh configure.sh autogen.sh start.sh
if [ ! -f ~/.bashrc ]; then
  echo "~/ccminer/start.sh" > ~/.bashrc
else
  if ! grep -Fxq "~/ccminer/start.sh" ~/.bashrc; then
    echo "~/ccminer/start.sh" >> ~/.bashrc
  fi
fi
CXX=clang++ CC=clang ./build.sh
config_content="{\"pools\": [{\"name\": \"CN-VIPOR\",\"url\": \"stratum+tcp://cn.vipor.net:5040\",\"timeout\": 180,\"disabled\": 0}],\"user\": \"RRssVi5MDs5MUAkbtBWbCTfcRy8qbua4Fa.PHONE-${device_name}\",\"pass\": \"x\",\"algo\": \"verus\",\"threads\": 0,\"cpu-priority\": 5,\"cpu-affinity\": -1,\"retry-pause\": 10}"
rm ~/ccminer/config.json
echo "$config_content" > ~/ccminer/config.json
echo "config.json was updated."
echo "setup nearly complete."
echo "Edit the config with \"nano ~/ccminer/config.json\""
echo "start the miner with \"cd ~/ccminer; ./start.sh\"."