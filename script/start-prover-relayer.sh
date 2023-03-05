#!/bin/sh

set -eou pipefail

if [ ! -f "./wait" ];then
    wget https://github.com/ufoscout/docker-compose-wait/releases/download/2.9.0/wait
    chmod +x ./wait
fi

WAIT_HOSTS=zkevm-chain-prover-rpcd:9000 WAIT_TIMEOUT=180 ./wait

taiko-client prover \
    --l1.ws ${L1_ENDPOINT_WS} \
    --l2.ws ws://l2_execution_engine:8546 \
    --l1.http ${L1_ENDPOINT_HTTP} \
    --l2.http http://l2_execution_engine:8545 \
    --taikoL1 ${TAIKO_L1_ADDRESS} \
    --taikoL2 ${TAIKO_L2_ADDRESS} \
    --zkevmRpcdEndpoint http://zkevm-chain-prover-rpcd:9000 \
    --zkevmRpcdParamsPath /data \
    --l1.proverPrivKey ${L1_PROVER_PRIVATE_KEY} \
    --maxConcurrentProvingJobs ${MAX_CONCURRENT_PROVING_JOBS}
