#include "cpppt/dummy.hpp"
#include <catch2/catch.hpp>

TEST_CASE("Dummy")
{
	REQUIRE(cpppt::hello_world() == "Hello World!");
}
