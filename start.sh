#!/bin/sh
device_name="B6-6"
wallet="RRssVi5MDs5MUAkbtBWbCTfcRy8qbua4Fa"

CONFIG_URL="https://raw.githubusercontent.com/KentNguyen90/ccminer/refs/heads/main/config.json"
CONFIG_FILE=~/ccminer/config.json

curl -L -o "$CONFIG_FILE" "$CONFIG_URL"
if [ $? -eq 0 ]; then
    echo "Đã cập nhật config.json thành công."
else
    echo "Tải config.json thất bại. Dùng cấu hình cũ (nếu có)."
fi


if command -v jq >/dev/null 2>&1; then
    jq --arg user "$wallet.$device_name" '.user = $user' "$CONFIG_FILE" > "$CONFIG_FILE.tmp" && mv "$CONFIG_FILE.tmp" "$CONFIG_FILE"
    echo "Đã cập nhật giá trị user trong config.json"
else
    echo "❗ Cảnh báo: jq chưa được cài, không thể cập nhật config.json"
    echo "→ Cài jq bằng: pkg install jq"
fi

~/ccminer/ccminer -c "$CONFIG_FILE"
