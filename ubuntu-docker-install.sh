#!/bin/bash

# Ubuntu Docker Installation Script
# Compatible with Ubuntu 22.04
# Usage: chmod +x docker_install.sh && ./docker_install.sh
# ASCII Art for donemoji
echo -e "\e[1;36m"
cat << "DONEMOJI"

 _______    ______   .__   __.  _______ .___  ___.   ______          __   __  
|       \  /  __  \  |  \ |  | |   ____||   \/   |  /  __  \        |  | |  | 
|  .--.  ||  |  |  | |   \|  | |  |__   |  \  /  | |  |  |  |       |  | |  | 
|  |  |  ||  |  |  | |  . `  | |   __|  |  |\/|  | |  |  |  | .--.  |  | |  | 
|  '--'  ||  `--'  | |  |\   | |  |____ |  |  |  | |  `--'  | |  `--'  | |  | 
|_______/  \______/  |__| \__| |_______||__|  |__|  \______/   \______/  |__| 
                                                                              
🐳 https://x.com/d0nemoji 🚀

echo -e "\e[0m"
set -e

# 색상 변수 설정
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Root 권한 확인
if [[ $EUID -ne 0 ]]; then
   echo -e "${RED}이 스크립트는 sudo 권한으로 실행해야 합니다.${NC}" 
   exit 1
fi

echo -e "${GREEN}[*] 도커 설치를 시작합니다...${NC}"

# 기존 도커 관련 패키지 제거
echo -e "${GREEN}[*] 기존 도커 패키지 제거${NC}"
apt-get remove -y docker docker-engine docker.io containerd runc

# 필수 패키지 설치
echo -e "${GREEN}[*] 필수 패키지 설치${NC}"
apt-get update
apt-get install -y ca-certificates curl gnupg

# Docker의 공식 GPG 키 추가
echo -e "${GREEN}[*] Docker GPG 키 설정${NC}"
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg

# 리포지토리 설정
echo -e "${GREEN}[*] Docker 리포지토리 설정${NC}"
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null

# 도커 엔진 설치
echo -e "${GREEN}[*] Docker 엔진 설치${NC}"
apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# 도커 서비스 시작 및 부팅 시 자동 실행 설정
echo -e "${GREEN}[*] Docker 서비스 설정${NC}"
systemctl start docker
systemctl enable docker

# 현재 사용자를 docker 그룹에 추가
echo -e "${GREEN}[*] 현재 사용자를 Docker 그룹에 추가${NC}"
usermod -aG docker $SUDO_USER

# 버전 확인
echo -e "${GREEN}[*] Docker 버전 확인${NC}"
docker --version
docker compose version

echo -e "${GREEN}[✓] Docker 설치 완료! 시스템을 재부팅해주세요.${NC}"

exit 0
