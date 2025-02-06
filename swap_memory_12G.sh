#!/bin/bash

set -e

SWAPFILE=/swapfile
SWAPSIZE=12G

# 기존 스왑 비활성화 및 삭제
sudo swapoff -a
sudo rm -f $SWAPFILE

# 새로운 스왑 파일 생성
sudo fallocate -l $SWAPSIZE $SWAPFILE
sudo chmod 600 $SWAPFILE
sudo mkswap $SWAPFILE
sudo swapon $SWAPFILE

# /etc/fstab에 추가하여 부팅 시 자동 적용
grep -qxF "$SWAPFILE none swap sw 0 0" /etc/fstab || echo "$SWAPFILE none swap sw 0 0" | sudo tee -a /etc/fstab

# 적용 확인
free -h
echo "스왑 메모리 $SWAPSIZE 설정 완료."
