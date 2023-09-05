#!/bin/bash

export VAULT_TOKEN=$1
export VAULT_ADDR=$2

NL=$'\n'
while read -r line; do
    key=$(echo $line | cut -d: -f1 | xargs)
    value=$(echo $line | cut -d: -f2 | xargs)
    sed -i "/^${key}=/d" $4 || true
    echo "${key}=${value}" >> $4
done < <(vault kv get -format=yaml -field=data $3)
