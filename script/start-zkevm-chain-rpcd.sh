#!/bin/sh

set -eou pipefail

mkdir -p /data


if [ ! -f "/data/19.bin" ];then
    wget https://storage.googleapis.com/zkevm-circuits-keys/19.bin -P /data
fi

if [ ! -f "/data/21.bin" ];then
    wget -nc https://storage.googleapis.com/zkevm-circuits-keys/21.bin -P /data
fi

/prover_rpcd --bind 0.0.0.0:9000
