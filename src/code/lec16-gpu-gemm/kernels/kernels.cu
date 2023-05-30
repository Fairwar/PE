#include "../include/kernel_00.cuh"
#include "../include/kernel_01.cuh"
#include "../include/kernel_02.cuh"
#include "../include/kernel_03.cuh"
#include "../include/typename.h"

void pe_dgemm_v0(int M, int N, int K, pe_f64 alpha, pe_f64* A, pe_f64* B, 
                 pe_f64 beta, pe_f64* C) {
    cudaDeviceSynchronize();
    dim3 blockDim(32,32);
    //ceil(M/32) ceil(N/32)
    dim3 gridDim((M + 31) >> 5, (N + 31) >> 5);
    pe_gemm_v0<pe_f64><<<gridDim, blockDim>>>(M,N,K,alpha,A,B,beta,C);
    cudaDeviceSynchronize();
}

void pe_dgemm_v1(int M, int N, int K, pe_f64 alpha, pe_f64* A, pe_f64* B, 
                 pe_f64 beta, pe_f64* C) {
    cudaDeviceSynchronize();
    dim3 blockDim(32,32);
    //ceil(M/32) ceil(N/32)
    dim3 gridDim((M + 31) >> 5, (N + 31) >> 5);
    pe_gemm_v1<pe_f64, 32, 32, 32><<<gridDim, blockDim>>>(M,N,K,alpha,A,B,beta,C);
    cudaDeviceSynchronize();
}

void pe_dgemm_v2(int M, int N, int K, pe_f64 alpha, pe_f64* A, pe_f64* B, 
                 pe_f64 beta, pe_f64* C) {
    cudaDeviceSynchronize();
    dim3 blockDim(32,32);
    //ceil(M/32) ceil(N/32)
    dim3 gridDim((M + 31) >> 5, (N + 31) >> 5);
    pe_gemm_v2<pe_f64, 32, 32, 32><<<gridDim, blockDim>>>(M,N,K,alpha,A,B,beta,C);
    cudaDeviceSynchronize();
}

void pe_dgemm_v3(int M, int N, int K, pe_f64 alpha, pe_f64* A, pe_f64* B, 
                 pe_f64 beta, pe_f64* C) {
    cudaDeviceSynchronize();
    dim3 blockDim(32,32);
    //ceil(M/32) ceil(N/32)
    dim3 gridDim((M + 31) >> 5, (N + 31) >> 5);
    pe_gemm_v3<pe_f64, 32, 32, 32><<<gridDim, blockDim>>>(M,N,K,alpha,A,B,beta,C);
    cudaDeviceSynchronize();
}
