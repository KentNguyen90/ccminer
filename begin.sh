yes | pkg update && pkg upgrade
yes | pkg install libjansson wget nano binutils git build-essential

cp /data/data/com.termux/files/usr/include/linux/sysctl.h /data/data/com.termux/files/usr/include/sys

git clone https://github.com/KentNguyen90/joy3.git

cd joy3

chmod +x ccminer start.sh build.sh configure.sh autogen.sh

./build.sh

# Enter Name Phone
echo "Nhập tên máy (ví dụ: PHONE-45):"
read PHONE_NUMBER

sed -i "s/-x/$PHONE_NUMBER/" config.json

echo "Setup nearly complete. Config.json updated with PHONE_NUMBER=$PHONE_NUMBER."

nano config.json

./start.sh

echo "Setup complete. Mining has started."
