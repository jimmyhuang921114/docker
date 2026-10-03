#!/usr/bin/env bash

#找尋剛剛建立好的Image
IMAGE_NAME="my-ros2:dev"

# 允許 Docker 使用 X11 顯示 GUI（例如 RViz2）
xhost +local:docker


YELLOW='\033[1;33m'
NC='\033[0m'
# 顯示狀態
echo -e "${YELLOW}===== 進入 Docker 容器 =====${NC}"

# ---工作目錄以 "主機目錄為主"
# 找到主機目錄位置
HOST_DIR="$(pwd)"


# 啟動並直接進入 Docker
docker run -it --rm \
  --net=host \
  --privileged \
  -e DISPLAY=$DISPLAY \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v /dev:/dev \
  -v "$HOST_DIR":"$HOST_DIR" \
  -w "$HOST_DIR" \
  "$IMAGE_NAME" \
  bash




# ----工作目錄以 "工作區域為主" ----#

# 取得目前腳本上一層目錄
# SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
# MOUNT_DIR="$(dirname "$SCRIPT_DIR")"



# 進入工作區塊
# docker run -it --rm \
  # --net=host \
  # --privileged \
  # -e DISPLAY=$DISPLAY \
  # -v /tmp/.X11-unix:/tmp/.X11-unix \
  # -v /dev:/dev \
  # -v "$MOUNT_DIR":/workspace \
  # -w /workspace \
  # "$IMAGE_NAME" \
  # bash