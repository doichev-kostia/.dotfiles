#!/usr/bin/env bash

set -ex

sudo mkdir -p /usr/local/opt/gcp
sudo mkdir -p /usr/local/opt/google-cloud-sdk

wget https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-darwin-arm.tar.gz 

tar -xzf google-cloud-cli-darwin-arm.tar.gz -C /tmp

# cleanup
sudo rm -rf /usr/local/opt/google-cloud-sdk/*

# move all the contents
sudo mv /tmp/google-cloud-sdk/* /usr/local/opt/google-cloud-sdk/

# Remove the tarball
rm google-cloud-cli-darwin-arm.tar.gz

uv python install 3.12

cd /usr/local/opt/
export CLOUDSDK_PYTHON="$HOME/.local/share/uv/python/cpython-3.12.7-macos-aarch64-none/bin/python"
sudo ./google-cloud-sdk/install.sh 

