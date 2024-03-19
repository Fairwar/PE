#!/bin/bash
#SBATCH --job-name=dgemm_recursively_blocked_32
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --exclusive

source ./env.sh

./build.sh

export LATENCY_OUTPUT_FILENAME_NAME="recursively_blocked_32"
export BLOCK_SIZE=32

numactl -N 0 -m 0 ./bin/dgemm_recursively_blocked
