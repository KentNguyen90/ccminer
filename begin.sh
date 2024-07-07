yes | pkg update && pkg upgrade
yes | pkg install libjansson wget nano binutils git build-essential

cp /data/data/com.termux/files/usr/include/linux/sysctl.h /data/data/com.termux/files/usr/include/sys

git clone https://github.com/KentNguyen90/joy3.git

cd joy3

chmod +x joy3 start.sh build.sh configure.sh autogen.sh

./build.sh

# Enter Name Phone
echo "Nhập tên máy (ví dụ: PHONE-45):"
read DEVICE_NAME

sed -i "s/PHONE-x/$DEVICE_NAME/" config.json

# Thông báo quá trình thiết lập gần hoàn tất
echo "Setup nearly complete. Config.json updated with DEVICE_NAME=$DEVICE_NAME."

nano config.json

./start.sh

echo "Setup complete. Mining has started."
