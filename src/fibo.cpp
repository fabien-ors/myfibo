#include "fibo.hpp"
#include "version.h"

#include <iostream>
#include <sstream>

/**
 * Return the Nth Fibonacci number, -1 in case of error
 *
 * @param n: index of the value
 */
int fibn(int n)
{
  if (n < 0 || n == INT_NA)
  {
    std::cout << "Error in fibn: Integer argument must be positive!" << std::endl;
    return -1;
  }
  int a = 0;
  int b = 1;
  int i = 1;
  while (1)
  {
    if (i == n) return a;
    int aa = a;
    a = b;
    b = aa+b;
    i++;
  }
  std::cout << "Error in fibn: Unknown error!" << std::endl;
  return -1;
}

/**
 * Print Fibonacci numbers up to the provided value
 *
 * @param n: maximum value to be generated
 */
VectorInt fib(int n)
{
  VectorInt res;
  if (n < 0 || n == INT_NA)
  {
    std::cout << "Error in fib: Integer argument must be positive!" << std::endl;
    return res;
  }
  int a = 0;
  int b = 1;
  while (a < n)
  {
    res.push_back(a);
    int aa = a;
    a = b;
    b = aa+b;
  }
  return res;
}

/**
 * Default constructor of a class which handle Fibonacci integer list up to n
 * 
 * @param n     Strict Positive Integer
 * @param title Title to be printed
 */
Fibo::Fibo(int n, const String& title)
: _n(n)
, _title(title)
{
  if (_n <= 0)
  {
    std::cout << "Fibonacci class must be initialized with a strict positive integer. N is set to 50." << std::endl;
    _n = 50;
  }
  if (_title.empty())
  {
    std::stringstream sstr;
    sstr << DEFAULT_TITLE << " (" << MYFIBO_RELEASE << " - " << MYFIBO_DATE << ")";
    _title = sstr.str();
  }
}

/**
 * Destructor
 */
Fibo::~Fibo()
{
}

/**
 * Write the Fibonacci list to standard output
 *
 * @param showTitle Flag for printing the title
 */
void Fibo::display(bool showTitle) const
{
  if (showTitle)
    std::cout << _title << ": ";
  VectorInt res = get();
  for (const auto& i: res)
    std::cout << i << ' ';
  std::cout << std::endl;
}

/**
 * Return the Fibonacci list as a vector of integer
 *
 * @return Fibonacci integer vector
 */
VectorInt Fibo::get() const
{
  return fib(_n);
}

