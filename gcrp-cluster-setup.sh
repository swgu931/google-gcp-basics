#!/bin/bash

1) gcloud components install kubectl

2) Install the Bazel build system : Using Bazel's apt repository

sudo apt install curl gnupg
curl -fsSL https://bazel.build/bazel-release.pub.gpg | gpg --dearmor > bazel.gpg
sudo mv bazel.gpg /etc/apt/trusted.gpg.d/
echo "deb [arch=amd64] https://storage.googleapis.com/bazel-apt stable jdk1.8" | sudo tee /etc/apt/sources.list.d/bazel.list
echo "deb [arch=amd64] https://storage.googleapis.com/bazel-apt stable jdk1.8" | tee /etc/apt/sources.list.d/bazel.list

sudo apt update && sudo apt install bazel

apt update && apt install bazel

sudo apt install bazel-1.0.0

sudo ln -s /usr/bin/bazel-1.0.0 /usr/bin/bazel
bazel --version  # 1.0.0


# optional ===============
# Ubuntu 16.04 (LTS) uses OpenJDK 8 by default:
sudo apt install openjdk-8-jdk

# Ubuntu 18.04 (LTS) uses OpenJDK 11 by default:
sudo apt install openjdk-11-jdk
# =============================


3) sudo apt-get install default-jdk git python-dev unzip xz-utils


# [ Build and deploy ]

git clone https://github.com/googlecloudrobotics/core
cd core

gcloud auth application-default login
gcloud auth configure-docker

./deploy.sh set_config [PROJECT_ID]

gsutil cat gs://[PROJECT_ID]-cloud-robotics-config/config.sh

bazel build //...

./deploy.sh create [PROJECT_ID]




