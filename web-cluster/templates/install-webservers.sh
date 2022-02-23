#!/bin/bash
DEVICE="/dev/xvdf"
FS_TYPE=$(sudo file -s $DEVICE | awk '{print $2}')
MOUNT_POINT=/var/log/applog
if [ "$FS_TYPE" = "data" ]
then
    sudo mkfs.xfs $DEVICE
fi
sudo mkdir -p $MOUNT_POINT
sudo mount $DEVICE $MOUNT_POINT
echo "$DEVICE $MOUNT_POINT xfs defaults,noatime 0 0" | sudo tee -a /etc/fstab
sudo yum udpate -y
sudo yum install httpd -y
sudo systemctl start httpd
sudo systemctl enable httpd
echo "<h1>Welcome to the application</h1>" > /var/www/html/index.html