# Library
set(
    LIBRARY_SOURCES
    cpppt/dummy.hpp
    cpppt/dummy.cpp
)

add_library(${PROJECT_NAME}_lib ${LIBRARY_SOURCES})

target_include_directories(
    ${PROJECT_NAME}_lib
    PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}
)

target_compile_features(
    ${PROJECT_NAME}_lib
    PUBLIC
    cxx_std_14
)

target_link_libraries(${PROJECT_NAME}_lib PRIVATE project_warnings)

# Unit Tests
if (BUILD_TESTS)
    set(
        UNIT_TEST_SOURCES
        cpppt/dummy.test.cpp
        unit_tests.cpp
    )

    add_executable(${PROJECT_NAME}_unit_tests ${UNIT_TEST_SOURCES})

    find_package(
        Catch2
        CONFIG
        REQUIRED
    )

    target_link_libraries(
        ${PROJECT_NAME}_unit_tests
        PRIVATE
            project_warnings
            ${PROJECT_NAME}_lib
            Catch2::Catch2
    )

    set(PARSE_CATCH_TESTS_ADD_TARGET_IN_TEST_NAME OFF)
    include(ParseAndAddCatchTests)
    parseandaddcatchtests(${PROJECT_NAME}_unit_tests)
endif ()

# Application
add_executable(${PROJECT_NAME} main.cpp)

target_link_libraries(
    ${PROJECT_NAME}
    PRIVATE
        project_warnings
        ${PROJECT_NAME}_lib
)

# Install
install(
    TARGETS ${PROJECT_NAME}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
)

install(
    DIRECTORY ${CMAKE_BINARY_DIR}/licenses
    DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/${PROJECT_NAME}
)
install(
    FILES
        ${PROJECT_SOURCE_DIR}/LICENSE
        ${PROJECT_SOURCE_DIR}/README.md
    DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/${PROJECT_NAME}
)

# Package
set(CPACK_RESOURCE_FILE_LICENSE ${PROJECT_SOURCE_DIR}/LICENSE)

set(CPACK_NSIS_ENABLE_UNINSTALL_BEFORE_INSTALL ON)
set(CPACK_NSIS_EXECUTABLES_DIRECTORY ${CMAKE_INSTALL_BINDIR})
set(
    CPACK_NSIS_MENU_LINKS
    ${CMAKE_INSTALL_BINDIR}/${PROJECT_NAME}
    ${PROJECT_NAME}
)
set(CPACK_NSIS_MUI_FINISHPAGE_RUN ${PROJECT_NAME})

include(CPack)
