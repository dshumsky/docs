#include <iostream>
using namespace std;

int main()
{
	int *ptr = NULL;
	*ptr = 100; // Write to invalid memory address
	// Segmentation fault (core dumped)
}
