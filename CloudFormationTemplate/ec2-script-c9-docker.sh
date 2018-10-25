#!/bin/bash

# Set Path
echo "Starting Amazon Workshop Script ..."
cd ~

sudo amazon-linux-extras install docker
sudo service docker start

mkdir /home/ec2-user/workspace
cd ~/workspace
# Copy the clients used for the labs
wget https://s3.amazonaws.com/amazon-mq-workshop/labs-clients.zip
unzip labs-clients.zip
rm labs-clients.zip
chmod +x *.jar


cd ~
wget https://s3.amazonaws.com/amazon-mq-workshop/Dockerfile

sudo docker build -t cloud9 .
sudo docker run -d -v /home/ec2-user/workspace:/workspace -p 8181:8181 cloud9 --auth aws:mq

# Signal CF 
echo "Tell CloudFormation we're done ..."
bash /signal.txt
sudo rm /ec2-script-c9-docker.sh
sudo rm /bash_env
