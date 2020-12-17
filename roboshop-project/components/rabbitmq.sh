#!/bin/bash

COMPONENT=rabbitmq
source components/common.sh

INFO "Setup RabbitMQ Component"

INFO "Install ErLang"
yum list esl-erlang &>>$LOG_FILE
case $? in
  0)
    STAT 0 "ErLang Installation"
    ;;
  1)
    yum install https://packages.erlang-solutions.com/erlang/rpm/centos/7/x86_64/esl-erlang_22.2.1-1~centos~7_amd64.rpm -y &>>$LOG_FILE
    STAT $? "ErLang Installation"
    ;;
esac

INFO "Setup RabbitMQ Repos"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | sudo bash &>>$LOG_FILE
STAT $? "RabbitMQ Yum repos setup"

INFO "Install RabbitMQ Server"
yum install rabbitmq-server -y &>>$LOG_FILE
STAT $? "RabbitMQ server Install"

INFO "Start RabbitMQ Service"
systemctl enable rabbitmq-server  &>>$LOG_FILE
systemctl start rabbitmq-server &>>$LOG_FILE
STAT $? "Start RabbitMQ Service"

INFO "Create RoboShop App User in RabbitMQ"
rabbitmqctl add_user roboshop roboshop123 &>>$LOG_FILE
rabbitmqctl set_user_tags roboshop administrator &>>$LOG_FILE
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>$LOG_FILE
STAT $? "RoboShop App USer create"
