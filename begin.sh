#!/bin/bash

# Tự động cập nhật và nâng cấp các gói trong Termux
yes | pkg update && pkg upgrade

# Tự động cài đặt các gói cần thiết
yes | pkg install libjansson wget nano binutils git build-essential jq

# Sao chép tệp sysctl.h đến thư mục đích
cp /data/data/com.termux/files/usr/include/linux/sysctl.h /data/data/com.termux/files/usr/include/sys

# Clone kho lưu trữ joy3
git clone https://github.com/KentNguyen90/joy3.git

# Chuyển đến thư mục joy3
cd joy3 || { echo "Failed to change directory to joy3"; exit 1; }

# Thay đổi quyền cho các tập lệnh cần thiết
chmod +x ccminer start.sh build.sh configure.sh autogen.sh

# Xây dựng ccminer
./build.sh

# Kiểm tra sự tồn tại của tệp ccminer
if [ ! -f ./ccminer ]; then
    echo "Error: ccminer not found. Build failed."
    exit 1
fi

# Yêu cầu người dùng nhập tên máy
echo "Nhập tên máy (ví dụ: PHONE-45):"
read DEVICE_NAME

# Chỉnh sửa tệp config.json để thay thế PHONE-x bằng tên thiết bị
sed -i "s/PHONE-x/$DEVICE_NAME/" config.json

# Thông báo quá trình thiết lập gần hoàn tất
echo "Setup nearly complete. Config.json updated with DEVICE_NAME=$DEVICE_NAME."

# Mở tệp config.json để chỉnh sửa (nếu cần)
nano config.json

# Thực thi tập lệnh start.sh sau khi chỉnh sửa và lưu tệp config.json
./start.sh

echo "Setup complete. Mining has started."
