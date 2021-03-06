#include "fibo.hpp"
#include "stdoutredirect.hpp"

#include <iostream>

int main()
{
  StdoutRedirect sr("testFibo.out");

  Fibo f1(50);
  f1.display(false);
  Fibo f2(100, "Test 100");
  f2.display();
  VectorInt vec = fib(40);
  for(auto v : vec) std::cout << v << " ";
  std::cout << std::endl;

  return 0;
}
