#!/bin/bash

# ASCII Art 한 줄씩 출력
echo " _______    ______   .__   __.  _______ .___  ___.   ______          __   __  " 
echo "|       \  /  __  \  |  \ |  | |   ____||   \/   |  /  __  \        |  | |  | " 
echo "|  .--.  ||  |  |  | |   \|  | |  |__   |  \  /  | |  |  |  |       |  | |  | " 
echo "|  |  |  ||  |  |  | |  . `  | |   __|  |  |\/|  | |  |  |  | .--.  |  | |  | " 
echo "|  '--'  ||  `--'  | |  |\   | |  |____ |  |  |  | |  `--'  | |  `--'  | |  | " 
echo "|_______/  \______/  |__| \__| |_______||__|  |__|  \______/   \______/  |__| " 
echo "🤑https://x.com/d0nemoji"

# Swap memory 설정
sudo fallocate -l 12G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile

# /etc/fstab에 추가
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab

# 스왑 설정 확인
sudo swapon --show
free -h

# Swapiness 설정 (optional)
echo 'vm.swappiness=10' | sudo tee -a /etc/sysctl.conf
sudo sysctl -p

echo "12G 스왑 메모리 설정이 완료되었습니다."

exit 0
