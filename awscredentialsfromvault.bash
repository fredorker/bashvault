#!/bin/bash

while read -r line; do
    key=$(echo $line | cut -d: -f1 | xargs)
    value=$(echo $line | cut -d: -f2 | xargs)
    if [ "$key" = "access_key" ]; then
      aws configure set aws_access_key_id $value
    fi
    if [ "$key" = "secret_key" ]; then
      aws configure set aws_secret_access_key $value
    fi
done < <(VAULT_TOKEN=$1 VAULT_ADDR=$2 vault read -format=yaml $3)
