file(
    GLOB_RECURSE
    UNIT_TEST_MERGED_SOURCES
    CONFIGURE_DEPENDS
    ${PROJECT_SOURCE_DIR}/src/*.test.*pp
)

file(
    GLOB_RECURSE
    UNIT_TEST_SEPARATE_SOURCES
    CONFIGURE_DEPENDS
    unit_tests/*.*pp
)

set(
    UNIT_TEST_SOURCES
    unit_tests.main.cpp
    ${UNIT_TEST_MERGED_SOURCES}
    ${UNIT_TEST_SEPARATE_SOURCES}
)

add_executable(unit_tests ${UNIT_TEST_SOURCES})

find_package(
    Catch2
    CONFIG
    REQUIRED
)

target_link_libraries(
    unit_tests PRIVATE $<TARGET_NAME_IF_EXISTS:${PROJECT_NAME}_lib>
                       Catch2::Catch2
)

include(warnings)
target_enable_warnings(unit_tests)

target_compile_features(unit_tests PRIVATE cxx_std_17)

include(Catch)
catch_discover_tests(unit_tests)
