#!/bin/bash
#SBATCH --job-name=prefetch20
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --exclusive

source ./env.sh

./build.sh

# export SAMPLE_POINTS=16
# export ACCESS_REGION_START=256
# export ACCESS_REGION_END=268435456

export PREFETCH_COUNT=20
export LATENCY_OUTPUT_FILENAME_PREFIX="mem_prefetch_20"

numactl -N 0 -m 0 ./bin/mem_prefetch
