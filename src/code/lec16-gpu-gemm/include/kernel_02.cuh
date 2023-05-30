#include<stdio.h>
#include<stdlib.h>

//shared memory blocking
//transform B in shared memory to optimize shared memory visit
template <typename T,
          unsigned int MS,
          unsigned int NS,
          unsigned int KS>
__global__  
void pe_gemm_v2(int M, int N, int K, T alpha, T* A, T* B, T beta, T* C){
    int lda = M, ldb = K, ldc = M;
    int tx = threadIdx.x, ty = threadIdx.y;
    int bx = blockIdx.x, by = blockIdx.y;
    T* A_bptr = &A[bx * MS];
    T* B_bptr = &B[by * NS * ldc];
    T* C_bptr = &C[bx * MS + by * NS * ldc];
    __shared__ T sA[MS*KS];
    __shared__ T sB[KS*NS];
    T tmp=0.;
    for (int kb = 0; kb < K; kb += KS){
        //column-major storage
        sA[tx + ty * MS] = A_bptr[tx + ty * lda];
        //transform B in shared memory, though may have no perfmrance impact
        //sB[tx + ty * KS] = B_bptr[tx + ty * ldb];
        sB[ty + tx * NS] = B_bptr[tx + ty * ldb];
        A_bptr += lda * KS;
        B_bptr += KS;
        __syncthreads();
        for (int kk = 0; kk < KS; kk++){
            //tmp += sA[tx + kk * MS] * sB[ty * KS + kk];
            tmp += sA[tx + kk * MS] * sB[ty + kk * NS];
        }
        __syncthreads();
    }
    C_bptr[tx + ty * ldc] = alpha * tmp + beta * C[tx + ty * ldc];
}
