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
            OUTPUT_NAME ${PROJECT_NAME}
            VERSION ${PROJECT_VERSION}
            SOVERSION ${PROJECT_VERSION_MAJOR}
    )

    target_include_directories(
        ${PROJECT_NAME}_lib PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}
    )

    target_compile_features(${PROJECT_NAME}_lib PUBLIC cxx_std_17)

    target_enable_warnings(${PROJECT_NAME}_lib)

    if (WIN32 AND BUILD_SHARED_LIBS)
        set_target_properties(
            ${PROJECT_NAME}_lib PROPERTIES WINDOWS_EXPORT_ALL_SYMBOLS ON
        )
    endif ()
endif ()

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
