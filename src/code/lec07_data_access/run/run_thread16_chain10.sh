#!/bin/bash
#SBATCH --job-name=t16c10
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --exclusive

source ./env.sh

./build.sh

export LATENCY_OUTPUT_FILENAME_PREFIX="mem_thread16_chain10"
export OMP_NUM_THREADS=16

numactl -N 0 -m 0 ./bin/mem_chain10_omp
