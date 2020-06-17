cmake_minimum_required(VERSION 3.14)

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
set(CMAKE_INSTALL_DOCDIR ${CMAKE_INSTALL_DATAROOTDIR}/doc/${PROJECT_NAME})

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

set(
    CMAKE_ARCHIVE_OUTPUT_DIRECTORY
    ${PROJECT_BINARY_DIR}/${CMAKE_INSTALL_LIBDIR}
)
set(
    CMAKE_LIBRARY_OUTPUT_DIRECTORY
    ${PROJECT_BINARY_DIR}/${CMAKE_INSTALL_LIBDIR}
)
set(
    CMAKE_RUNTIME_OUTPUT_DIRECTORY
    ${PROJECT_BINARY_DIR}/${CMAKE_INSTALL_BINDIR}
)

include(run-conan)
include(warnings)

add_subdirectory(src)
add_subdirectory(apps)
if (BUILD_TESTS)
    enable_testing()
    add_subdirectory(tests)
endif ()

# --------------
# Install
# --------------
install(
    DIRECTORY ${PROJECT_BINARY_DIR}/licenses
    DESTINATION ${CMAKE_INSTALL_DATADIR}/${PROJECT_NAME}
    COMPONENT ${PROJECT_NAME}_Always_Required
)

install(
    FILES ${CMAKE_CURRENT_LIST_DIR}/LICENSE.txt
    DESTINATION ${CMAKE_INSTALL_DATADIR}/${PROJECT_NAME}/
    COMPONENT ${PROJECT_NAME}_Always_Required
)

# --------------
# Packaging
# --------------
set(CPACK_PACKAGE_NAME ${PROJECT_NAME})
set(CPACK_PACKAGE_VENDOR "Humanity") # Change this value
set(CPACK_PACKAGE_INSTALL_DIRECTORY ${PROJECT_NAME})
set(CPACK_PACKAGE_VERSION_MAJOR ${PROJECT_VERSION_MAJOR})
set(CPACK_PACKAGE_VERSION_MINOR ${PROJECT_VERSION_MINOR})
set(CPACK_PACKAGE_VERSION_PATCH ${PROJECT_VERSION_PATCH})
set(CPACK_VERBATIM_VARIABLES TRUE)
set(CPACK_RESOURCE_FILE_LICENSE ${CMAKE_CURRENT_LIST_DIR}/LICENSE.txt)

set(CPACK_NSIS_ENABLE_UNINSTALL_BEFORE_INSTALL ON)
set(CPACK_NSIS_EXECUTABLES_DIRECTORY ${CMAKE_INSTALL_BINDIR})
set(CPACK_NSIS_MUI_FINISHPAGE_RUN ${PROJECT_NAME})

include(CPack)

cpack_add_component(
    ${PROJECT_NAME}_Always_Required
    REQUIRED
    HIDDEN
)

cpack_add_component(
    ${PROJECT_NAME}_Runtime
    DISPLAY_NAME Runtime
    DESCRIPTION "Shared libraries and executables" REQUIRED
    INSTALL_TYPES
        Full
        Developer
        Minimal
)

cpack_add_component(
    ${PROJECT_NAME}_Development
    DISPLAY_NAME "Libraries and Headers"
    DESCRIPTION "Static libraries and headers needed for building apps"
    DEPENDS ${PROJECT_NAME}_Runtime
    GROUP ${PROJECT_NAME}_SDK
    INSTALL_TYPES Full Developer
)

cpack_add_component_group(
    ${PROJECT_NAME}_SDK
    DISPLAY_NAME Development
    DESCRIPTION "Developer tools, libraries, etc."
)

cpack_add_install_type(Full)
cpack_add_install_type(Minimal)
cpack_add_install_type(Developer DISPLAY_NAME "Development")
