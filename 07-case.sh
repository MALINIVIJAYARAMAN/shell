#!/bin/bash

case $1 in
  frontend)
    echo Installing Frontend
    ;;
  mongo)
    echo Installing Mongo
    ;;
  catalogue)
    echo Installing Catalogue
    ;;
esac
