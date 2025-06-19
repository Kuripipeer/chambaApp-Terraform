#!/bin/bash
apt update
apt install -y docker.io git
systemctl enable docker
