#define CATCH_CONFIG_MAIN
#include <catch2/catch.hpp>

ANON_TEST_CASE()
{
    // NOLINTNEXTLINE (clang-analyzer-core.uninitialized.UndefReturn)
    SUCCEED("Test ran");
}
