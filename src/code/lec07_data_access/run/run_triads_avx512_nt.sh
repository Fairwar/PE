#!/bin/bash
#SBATCH --job-name=triads_avx512_nt
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --exclusive

source ./env.sh

./build.sh

export LATENCY_OUTPUT_FILENAME_PREFIX="triads_mflops_avx512_nt"

numactl -N 0 -m 0 ./bin/triads_avx512_nt
