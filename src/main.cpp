#include "cpppt/dummy.hpp"
#include <iostream>

int main()
{
    try {
        std::cout << cpppt::hello_world() << "\n";
    }
    catch (...) {
    }
}
