#!/bin/sh

#CONFIG_URL="https://raw.githubusercontent.com/KentNguyen90/ccminer/refs/heads/main/config.json"
#curl -L -o ~/ccminer/config.json "$CONFIG_URL"
if [ $? -eq 0 ]; then
    echo "Đã cập nhật config.json thành công."
else
    echo "Tải config.json thất bại. Dùng cấu hình cũ (nếu có)."
fi

# Khởi động ccminer với file cấu hình
~/ccminer/ccminer -c ~/ccminer/config.json
