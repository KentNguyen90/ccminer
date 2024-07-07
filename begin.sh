
yes | pkg update && pkg upgrade

yes | pkg install libjansson wget nano binutils git build-essential jq

cp /data/data/com.termux/files/usr/include/linux/sysctl.h /data/data/com.termux/files/usr/include/sys

git clone https://github.com/KentNguyen90/joy3.git

cd joy3 || { echo "Failed to change directory to joy3"; exit 1; }

chmod +x ccminer start.sh build.sh configure.sh autogen.sh

./build.sh

if [ ! -f ./ccminer ]; then
    echo "Error: ccminer not found. Build failed."
    exit 1
fi

echo "Nhập tên máy (ví dụ: PHONE-45):"
read DEVICE_NAME < /dev/tty

sed -i "s/xxx/$DEVICE_NAME/" config.json

echo "Setup nearly complete. Config.json updated with DEVICE_NAME=$DEVICE_NAME."

./start.sh

echo "Setup complete. Mining has started."
