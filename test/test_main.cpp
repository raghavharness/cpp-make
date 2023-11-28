#define CATCH_CONFIG_MAIN
#include <catch.hpp>
#include "mylibrary.hpp"

TEST_CASE("Addition tests", "[add]") {
    REQUIRE(add(2, 3) == 5);
    REQUIRE(add(-2, 3) == 1);
    REQUIRE(add(0, 0) == 0);
}

TEST_CASE("Addition tests fail", "[add]") {
    REQUIRE(add(2, 3) == 10);
}