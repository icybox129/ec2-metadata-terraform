#!/bin/bash
sudo -i
yum update -y
yum install -y git nodejs

mkdir ec2
cd ec2
git clone https://github.com/icybox129/ec2-metadata-app.git
cd ec2-metadata-app
npm i
node app.js