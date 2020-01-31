file(
    GLOB
    ENTRY_FILES
    CONFIGURE_DEPENDS
    *.cpp
)

foreach (ENTRY_FILE ${ENTRY_FILES})
    get_filename_component(
        APP_NAME
        ${ENTRY_FILE}
        NAME_WE
    )

    file(
        GLOB_RECURSE
        APP_SOURCES
        CONFIGURE_DEPENDS
        ${APP_NAME}/*.*pp
    )

    set(APP_SOURCES ${ENTRY_FILE} ${APP_SOURCES})

    add_executable(${APP_NAME} ${APP_SOURCES})

    target_link_libraries(
        ${APP_NAME} PRIVATE $<TARGET_NAME_IF_EXISTS:${PROJECT_NAME}_lib>
    )

    include(warnings)
    target_enable_warnings(${APP_NAME})

    target_compile_features(${APP_NAME} PRIVATE cxx_std_17)

    install(
        TARGETS ${APP_NAME}
        RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
        LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    )
endforeach ()
