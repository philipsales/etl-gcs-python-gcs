#!/bin/bash

read -p "Set Production environment? " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    ENV='dev'
else
    ENV='prod'
fi

echo $ENV
cd ../"$pwd"
rm -f .env
cat environment/"$ENV".env
ln -s environment/"$ENV".env .env
