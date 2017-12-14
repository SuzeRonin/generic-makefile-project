#include "gtest/gtest.h"

int Factorial(int);

int Factorial(int n)
{
	return n == 0 ? 1 : n * Factorial(n-1);
}

TEST(FactorialTest, HandlesZeroInput) {
  EXPECT_EQ(1, Factorial(0));
}


