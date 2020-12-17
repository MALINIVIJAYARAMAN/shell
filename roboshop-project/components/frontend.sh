#!/bin/bash

COMPONENT=frontend
source components/common.sh

INFO "Setup Frontend Component"
INFO "Installing Nginx"
yum install nginx -y &>>$LOG_FILE
STAT $? "Nginx Installation"

INFO "Downloading Artifacts"
DOWNLOAD_ARTIFACT "https://dev.azure.com/DevOps-Batches/f635c088-1047-40e8-8c29-2e3b05a38010/_apis/git/repositories/fdf87296-ccbe-45e5-a615-bc6ecbd78bfe/items?path=%2F&versionDescriptor%5BversionOptions%5D=0&versionDescriptor%5BversionType%5D=0&versionDescriptor%5Bversion%5D=master&resolveLfs=true&%24format=zip&api-version=5.0&download=true"


INFO "Remove Old Artifacts"
rm -rvf /usr/share/nginx/html/* &>>$LOG_FILE
STAT $? "Artifact Removal"

INFO "Extract Artifact Archive"
cd /usr/share/nginx/html
unzip -o /tmp/frontend.zip &>>$LOG_FILE
mv static/* .
STAT $? "Artifact Extract"

rm -rf static README.md # this not really needed, those files will not harm anything

INFO "Update Nginx Configuration"
mv localhost.conf /etc/nginx/default.d/roboshop.conf
sed -i  -e "/catalogue/ s/localhost/catalogue-test.devopsb53.tk/" \
        -e "/cart/ s/localhost/cart-test.devopsb53.tk/" \
        -e "/user/ s/localhost/user-test.devopsb53.tk/" \
        -e "/shipping/ s/localhost/shipping-test.devopsb53.tk/" \
        -e "/payment/ s/localhost/payment-test.devopsb53.tk/" \
        /etc/nginx/default.d/roboshop.conf
STAT $? "Nginx configuration update"

INFO "Start Nginx Service"
systemctl enable nginx &>>$LOG_FILE
systemctl restart nginx &>>$LOG_FILE
STAT $? "Nginx Service Startup"

