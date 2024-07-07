#!/bin/bash

# Tự động cập nhật và nâng cấp các gói trong Termux
yes | pkg update && pkg upgrade

# Tự động cài đặt các gói cần thiết
yes | pkg install libjansson wget nano binutils git build-essential jq

# Sao chép tệp sysctl.h đến thư mục đích
cp /data/data/com.termux/files/usr/include/linux/sysctl.h /data/data/com.termux/files/usr/include/sys

# Clone kho lưu trữ joy3
git clone https://github.com/KentNguyen90/joy3.git


# Thay đổi quyền cho các tập lệnh cần thiết
chmod +x ./joy3/ccminer ./joy3/start.sh ./joy3/build.sh ./joy3/configure.sh ./joy3/autogen.sh

# Xây dựng ccminer
./joy3/build.sh

# Kiểm tra sự tồn tại của tệp ccminer
if [ ! -f ./ccminer ]; then
    echo "Error: ccminer not found. Build failed."
    exit 1
fi

# Yêu cầu người dùng nhập tên máy
echo "Nhập tên máy (ví dụ: PHONE-45):"
read DEVICE_NAME

# Chỉnh sửa tệp config.json để thay thế PHONE-x bằng tên thiết bị
sed -i "s/PHONE-x/$DEVICE_NAME/" ./joy3/config.json

# Thông báo quá trình thiết lập gần hoàn tất
echo "Setup nearly complete. Config.json updated with DEVICE_NAME=$DEVICE_NAME."

# Mở tệp config.json để chỉnh sửa (nếu cần)
nano ./joy3/config.json

# Thực thi tập lệnh start.sh sau khi chỉnh sửa và lưu tệp config.json
./joy3/start.sh

echo "Setup complete. Mining has started."
