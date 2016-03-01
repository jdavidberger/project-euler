#include <iostream>
#include <string.h>
#include <stdio.h>
#include <vector>
typedef __int128_t int128_t;


int128_t mod_pow(int a,int n,int p)
{
  int128_t ret=1;
  int128_t A=a;
  while(n)
    {
      if (n & 1)
	ret=(ret*A)%p;
      A=(A*A)%p;
      n>>=1;
    }
  return ret;
}

template <uint64_t M>
static inline uint64_t factorial(size_t n) {
  static std::vector<uint64_t> f;

  if(n >= f.size()) {
    size_t n_ = f.size();
    f.resize(n+1);
    std::cout << n << std::endl; 
    if(n_ == 0 && n > 0) {
      f[0] = 1;
      n_ = 1; 
    }

    for(auto i = n_;i <= std::min(M,n);i++) {
      f[i] = f[i-1] * i % M;
    }
    std::cout << "Done " << n << std::endl; 
  }

  return f[n]; 
}

template <uint64_t p>
static inline int128_t Lucas(int128_t a,int128_t k)
{
  int128_t re = 1;
  while(a && k)
    {
      int128_t aa = a%p;
      int128_t bb = k%p;
      if(aa < bb) return 0;
      re = re*factorial<p>(aa)*mod_pow(factorial<p>(bb)*factorial<p>(aa-bb)%p,p-2,p)%p;
      a /= p;
      k /= p;
    }
  return re;
}
