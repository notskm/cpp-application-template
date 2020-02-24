cmake_minimum_required(VERSION 3.12)

option(
    BUILD_TESTS
    "Build the tests"
    OFF
)

project(
    cpp-application-template
    VERSION 0.1.0
    LANGUAGES CXX
)

include(GNUInstallDirs)

list(
    APPEND
    CMAKE_MODULE_PATH
    ${PROJECT_BINARY_DIR}
    ${PROJECT_SOURCE_DIR}/cmake
)

list(
    APPEND
    CMAKE_PREFIX_PATH
    ${PROJECT_BINARY_DIR}
)

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/bin)

include(run-conan)
include(warnings)

add_subdirectory(src)
add_subdirectory(apps)
if (BUILD_TESTS)
    enable_testing()
    add_subdirectory(tests)
endif ()

install(
    DIRECTORY ${PROJECT_BINARY_DIR}/licenses
    DESTINATION ${CMAKE_INSTALL_DATADIR}/${PROJECT_NAME}
)

install(
    FILES ${PROJECT_SOURCE_DIR}/LICENSE
    DESTINATION ${CMAKE_INSTALL_DATADIR}/${PROJECT_NAME}
)

set(CPACK_RESOURCE_FILE_LICENSE ${PROJECT_SOURCE_DIR}/LICENSE)

set(CPACK_NSIS_ENABLE_UNINSTALL_BEFORE_INSTALL ON)
set(CPACK_NSIS_EXECUTABLES_DIRECTORY ${CMAKE_INSTALL_BINDIR})
set(
    CPACK_NSIS_MENU_LINKS ${CMAKE_INSTALL_BINDIR}/${PROJECT_NAME}
                          ${PROJECT_NAME}
)
set(CPACK_NSIS_MUI_FINISHPAGE_RUN ${PROJECT_NAME})

include(CPack)
