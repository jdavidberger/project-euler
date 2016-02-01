#include <stdlib.h>
#include <stdio.h>
#include <memory.h>
#include <string.h>
#include <stdint.h>

// Mod math is for suckers
typedef __int128_t int128_t;

static inline int128_t P(int128_t N) {
  if(N == 1)
    return 1;
  if(N == 2 || N == 3)
    return 2; 
  ;
  int128_t idx = N/2 - P(N/2) + 1;
  return 2 * idx; 
}

static inline int128_t sum_series(int128_t n) {
  return n * (n+1) / 2;
}

int128_t S(int128_t n) {
  if(n == 0)
    return 0; 
  if(n == 1)
    return 1;
  if( n % 2 == 0) {
    return ((P(n)) + S(n-1));
  }
  
  int128_t n2 = n/2;
  int128_t n_contrib = (2*n-2);
  int128_t series_contrib = (4*sum_series(n2));
  int128_t Sn2_contrib    = (4*S(n2));
  return (n_contrib + series_contrib - Sn2_contrib + 1) ;
} 

int main() {
  printf("%llu\n", S((int128_t)1e18)%987654321);
}
