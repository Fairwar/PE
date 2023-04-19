#include "../include/pe_gemm.hpp"
#include "../include/help.hpp"
#include <cstdlib>

int main() {
  int64_t m, n, k, lda, ldb, ldc;
  struct timespec start, end;
  double time_used, flops, perf;
  //for simple
  m = n = k = lda = ldb = ldc = 1024; 
  double *A, *B, *C, *ref;
  A = (double *)malloc(lda * k * sizeof(double));
  B = (double *)malloc(ldb * k * sizeof(double));
  C = (double *)malloc(m * n * sizeof(double));
  ref = (double *)malloc(m * n * sizeof(double));

  init_matrix(A, m, n);
  init_matrix(B, m, n);
  init_matrix(C, m, n);
  copy_matrix(ref, C, m, n);

  //warm up
  pe_dgemm(m, n, k, A, lda, B, ldb, C, ldc);
  clock_gettime(CLOCK_MONOTONIC_RAW, &start);
  //call
  pe_dgemm(m, n, k, A, lda, B, ldb, C, ldc);
  clock_gettime(CLOCK_MONOTONIC_RAW, &end);
  flops = 2 * m * n * k;
  time_used = get_time(&start, &end);
  perf = flops / time_used * 1e-9;
  cout << "flops: " << flops << endl;
  cout << "time : " << time_used << endl;
  cout << "perf:  " << perf << endl;
  return 0;
}