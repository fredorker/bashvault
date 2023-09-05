#!/bin/bash

set -a

export VAULT_TOKEN=$1
export VAULT_ADDR=$2

while read -r line; do
    key=$(echo $line | cut -d: -f1 | xargs)
    value=$(echo $line | cut -d: -f2 | xargs)
    export $key="$value"
  done < <(vault kv get -format=yaml -field=data $3)