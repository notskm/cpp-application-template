cmake_minimum_required(VERSION 3.12)

option(
    BUILD_TESTS
    "Build the tests"
    OFF
)

project(cpp_project_templates VERSION 0.1.0 LANGUAGES CXX)

include(GNUInstallDirs)

set(
    CMAKE_MODULE_PATH
    ${CMAKE_BINARY_DIR}
    ${CMAKE_MODULE_PATH}
    ${PROJECT_SOURCE_DIR}/cmake
)

set(
    CMAKE_PREFIX_PATH
    ${CMAKE_BINARY_DIR}
    ${CMAKE_PREFIX_PATH}
)

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

include(warnings)

if (BUILD_TESTS)
    enable_testing()
endif ()

add_subdirectory(src)
