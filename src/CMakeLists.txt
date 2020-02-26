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
file(
    GLOB_RECURSE
    LIBRARY_SOURCES
    CONFIGURE_DEPENDS
    *.h
    *.hh
    *.hpp
    *.hxx
    *.h++
    *.inl
    *.c
    *.cc
    *.cpp
    *.cxx
    *.c++
)

list(
    FILTER
    LIBRARY_SOURCES
    EXCLUDE
    REGEX
    ".*\\.test\\..*"
)

if (LIBRARY_SOURCES)
    add_library(${PROJECT_NAME} ${LIBRARY_SOURCES})

    set_target_properties(
        ${PROJECT_NAME} PROPERTIES VERSION ${PROJECT_VERSION}
                                   SOVERSION ${PROJECT_VERSION_MAJOR}
    )

    target_include_directories(
        ${PROJECT_NAME} PUBLIC $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
                               $<INSTALL_INTERFACE:include>
    )

    target_compile_features(${PROJECT_NAME} PUBLIC cxx_std_17)

    target_enable_warnings(${PROJECT_NAME})

    if (WIN32 AND BUILD_SHARED_LIBS)
        set_target_properties(
            ${PROJECT_NAME} PROPERTIES WINDOWS_EXPORT_ALL_SYMBOLS ON
        )
    endif ()
endif ()

# --------------
# Install
# --------------
install(
    TARGETS ${PROJECT_NAME}
    EXPORT ${PROJECT_NAME}Targets
    RUNTIME COMPONENT ${PROJECT_NAME}_Runtime
    LIBRARY COMPONENT ${PROJECT_NAME}_Runtime
    ARCHIVE COMPONENT ${PROJECT_NAME}_Development
    INCLUDES
    COMPONENT ${PROJECT_NAME}_Development
)

install(
    DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/
    TYPE INCLUDE
    COMPONENT ${PROJECT_NAME}_Development
    FILES_MATCHING
    REGEX ".*\\.(h|hh|hpp|hxx|h\\+\\+|inl)"
)

include(CMakePackageConfigHelpers)
write_basic_package_version_file(
    ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}ConfigVersion.cmake
    COMPATIBILITY SameMajorVersion
)

export(
    EXPORT ${PROJECT_NAME}Targets
    NAMESPACE ${PROJECT_NAME}::
    FILE ${PROJECT_NAME}Targets.cmake
)

configure_package_config_file(
    ${PROJECT_SOURCE_DIR}/cmake/projectConfig.cmake.in
    ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}Config.cmake
    INSTALL_DESTINATION
    ${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME}
)

install(
    EXPORT ${PROJECT_NAME}Targets
    FILE ${PROJECT_NAME}Targets.cmake
    NAMESPACE ${PROJECT_NAME}::
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME}
    COMPONENT ${PROJECT_NAME}_Development
)

install(
    FILES ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}Config.cmake
          ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}ConfigVersion.cmake
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME}
    COMPONENT ${PROJECT_NAME}_Development
)
