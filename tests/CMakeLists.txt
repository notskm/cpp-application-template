file(
    GLOB_RECURSE
    UNIT_TEST_SOURCES
    CONFIGURE_DEPENDS
    unit_tests/*.h
    unit_tests/*.hh
    unit_tests/*.hpp
    unit_tests/*.hxx
    unit_tests/*.h++
    unit_tests/*.c
    unit_tests/*.cc
    unit_tests/*.cpp
    unit_tests/*.cxx
    unit_tests/*.c++
    unit_tests/*.inl
    ${PROJECT_SOURCE_DIR}/src/*.test.h
    ${PROJECT_SOURCE_DIR}/src/*.test.hh
    ${PROJECT_SOURCE_DIR}/src/*.test.hpp
    ${PROJECT_SOURCE_DIR}/src/*.test.hxx
    ${PROJECT_SOURCE_DIR}/src/*.test.h++
    ${PROJECT_SOURCE_DIR}/src/*.test.c
    ${PROJECT_SOURCE_DIR}/src/*.test.cc
    ${PROJECT_SOURCE_DIR}/src/*.test.cpp
    ${PROJECT_SOURCE_DIR}/src/*.test.cxx
    ${PROJECT_SOURCE_DIR}/src/*.test.c++
    ${PROJECT_SOURCE_DIR}/src/*.test.inl
)

set(UNIT_TEST_SOURCES unit_tests.main.cpp ${UNIT_TEST_SOURCES})

add_executable(unit_tests ${UNIT_TEST_SOURCES})

find_package(
    Catch2
    CONFIG
    REQUIRED
)

target_link_libraries(
    unit_tests PRIVATE $<TARGET_NAME_IF_EXISTS:${PROJECT_NAME}> Catch2::Catch2
)

include(warnings)
target_enable_warnings(unit_tests)

target_compile_features(unit_tests PRIVATE cxx_std_17)

include(Catch)
catch_discover_tests(unit_tests)
