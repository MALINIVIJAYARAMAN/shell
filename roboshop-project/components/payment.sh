#!/bin/bash

COMPONENT=payment
source components/common.sh

INFO "Setup Payment Component"

INFO "Installing Python3"
yum install python36 gcc python3-devel -y &>>$LOG_FILE
STAT $? "Python 3 Install"

INFO "Create Application User"
id roboshop &>>$LOG_FILE
case $? in
  0)
    STAT 0 "Application User Creation"
    ;;
  1)
    useradd roboshop &>>$LOG_FILE
  STAT $? "Application User Creation"
  ;;
esac


INFO "Download Payment Artifact"
DOWNLOAD_ARTIFACT "https://dev.azure.com/DevOps-Batches/f635c088-1047-40e8-8c29-2e3b05a38010/_apis/git/repositories/cd32a975-ee45-4b3b-a08e-8e97c3ca7733/items?path=%2F&versionDescriptor%5BversionOptions%5D=0&versionDescriptor%5BversionType%5D=0&versionDescriptor%5Bversion%5D=master&resolveLfs=true&%24format=zip&api-version=5.0&download=true"


INFO "Extract Downloaded Artifacts"
mkdir -p /home/roboshop/${COMPONENT}
cd /home/roboshop/${COMPONENT}
unzip -o /tmp/payment.zip &>>$LOG_FILE
STAT $? "Artifacts Extract"

chown roboshop:roboshop  /home/roboshop/${COMPONENT} -R &>>$LOG_FILE

INFO "Install Python Dependencies"
pip3 install -r requirements.txt &>>$LOG_FILE
STAT $? "Dependencies Download"


INFO "Configuring Payment Startup Script "
sed -i  -e "s/CARTHOST/cart-test.devopsb53.tk/" \
        -e "s/USERHOST/user-test.devopsb53.tk/" \
        -e "s/AMQPHOST/rabbitmq-test.devopsb53.tk/" \
        /home/roboshop/${COMPONENT}/systemd.service
USER_UID=$(id -u roboshop)
USER_GID=$(id -g roboshop)
sed -i  -e "/uid =/ c uid = ${USER_UID}" \
        -e "/gid =/ c gid = ${USER_GID}" \
        /home/roboshop/${COMPONENT}/payment.ini
STAT $? "Startup script configuration"


INFO "Setup SystemD Service for Payment"
mv /home/roboshop/${COMPONENT}/systemd.service /etc/systemd/system/${COMPONENT}.service
systemctl daemon-reload
STAT $? "Payment SystemD Service"

INFO "Starting Payment Service"
systemctl enable ${COMPONENT} &>>$LOG_FILE
systemctl restart ${COMPONENT} &>>$LOG_FILE
STAT $? "Payment Service Start"

