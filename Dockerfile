# FROM：建立相關作業環境 Ubuntu / Jetson / ARM / x86

# ==== ROS 2 Humble Desktop（含 RViz2 / rqt 等）====
FROM ros:humble-ros-base
# FROM osrf/ros:humble-desktop


ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV DEBIAN_FRONTEND=noninteractive \
    TZ=Asia/Taipei \
    SHELL=/bin/bash

# 基本套件安裝
# RUN:執行Linux指令
RUN apt-get update && apt-get install -y --no-install-recommends \
      build-essential \
      python3-colcon-common-extensions \
      python3-pip \
      tree \
      git \
      sudo \
      locales \
      ros-humble-turtlesim \
    && locale-gen en_US.UTF-8 \
    && update-locale LANG=en_US.UTF-8 \
    && rm -rf /var/lib/apt/lists/*

# Python 套件
RUN pip3 install --no-cache-dir \
      "numpy<2" \
scipy


# PyTorch CPU 版（VirtualBox 沒有 GPU）
RUN pip3 install --no-cache-dir torch torchvision \
      --index-url https://download.pytorch.org/whl/cpu

# YOLO
RUN pip3 install --no-cache-dir ultralytics "numpy<2"

# OpenCV
#RUN apt-get update && apt-get install -y \
#      python3-opencv \
#    && rm -rf /var/lib/apt/lists/*



# 新增環境內的使用者
# useradd:建立使用者
RUN useradd -ms /bin/bash work && \
    echo "work ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# USER:設定該使用者
USER work

# 設定作業空間
# WORKDIR:設定作業空間
WORKDIR /home/work

# ROS 2 環境設定
RUN echo 'source /opt/ros/$ROS_DISTRO/setup.bash' >> ~/.bashrc
CMD ["bash"]
