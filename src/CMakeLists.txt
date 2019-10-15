if (BUILD_SHARED_LIBS)
    set(CMAKE_DEBUG_POSTFIX -d)
    set(CMAKE_RELWITHDEBINFO_POSTFIX -rd)
else ()
    set(CMAKE_DEBUG_POSTFIX -s-d)
    set(CMAKE_RELEASE_POSTFIX -s)
    set(CMAKE_MINSIZEREL_POSTFIX -s)
    set(CMAKE_RELWITHDEBINFO_POSTFIX -s-rd)
endif ()

# --------------
# Library
# --------------
set(LIBRARY_SOURCES)

if (LIBRARY_SOURCES)
    add_library(${PROJECT_NAME}_lib ${LIBRARY_SOURCES})

    set_target_properties(
        ${PROJECT_NAME}_lib
        PROPERTIES
            OUTPUT_NAME
            ${PROJECT_NAME}
            VERSION
            ${PROJECT_VERSION}
            SOVERSION
            ${PROJECT_VERSION_MAJOR}
    )

    target_include_directories(
        ${PROJECT_NAME}_lib
        PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}
    )

    target_compile_features(
        ${PROJECT_NAME}_lib
        PUBLIC
        cxx_std_17
    )

    target_compile_options(${PROJECT_NAME}_lib PRIVATE ${PROJECT_WARNINGS})

    if (WIN32 AND BUILD_SHARED_LIBS)
        set_target_properties(
            ${PROJECT_NAME}_lib
            PROPERTIES
                WINDOWS_EXPORT_ALL_SYMBOLS
                ON
        )
    endif ()
endif ()

# --------------
# Unit Tests
# --------------
if (BUILD_TESTS)
    set(UNIT_TEST_SOURCES unit_tests.cpp)

    add_executable(${PROJECT_NAME}_unit_tests ${UNIT_TEST_SOURCES})

    find_package(
        Catch2
        CONFIG
        REQUIRED
    )

    target_link_libraries(
        ${PROJECT_NAME}_unit_tests
        PRIVATE
            $<TARGET_NAME_IF_EXISTS:${PROJECT_NAME}_lib>
            Catch2::Catch2
    )

    target_compile_options(
        ${PROJECT_NAME}_unit_tests
        PRIVATE ${PROJECT_WARNINGS}
    )

    target_compile_features(
        ${PROJECT_NAME}_unit_tests
        PRIVATE
        cxx_std_17
    )

    include(Catch)
    catch_discover_tests(${PROJECT_NAME}_unit_tests)
endif ()

# --------------
# Application
# --------------
add_executable(${PROJECT_NAME} main.cpp)

target_link_libraries(
    ${PROJECT_NAME}
    PRIVATE $<TARGET_NAME_IF_EXISTS:${PROJECT_NAME}_lib>
)

target_compile_options(${PROJECT_NAME} PRIVATE ${PROJECT_WARNINGS})

target_compile_features(
    ${PROJECT_NAME}
    PRIVATE
    cxx_std_17
)

# --------------
# Install
# --------------
if (TARGET ${PROJECT_NAME}_lib AND BUILD_SHARED_LIBS)
    install(
        TARGETS ${PROJECT_NAME}_lib
        RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
        LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    )
endif ()

install(
    TARGETS ${PROJECT_NAME}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
)
