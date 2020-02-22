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
        ${APP_NAME}/*.h
        ${APP_NAME}/*.hh
        ${APP_NAME}/*.hpp
        ${APP_NAME}/*.hxx
        ${APP_NAME}/*.h++
        ${APP_NAME}/*.c
        ${APP_NAME}/*.cc
        ${APP_NAME}/*.cpp
        ${APP_NAME}/*.cxx
        ${APP_NAME}/*.c++
        ${APP_NAME}/*.inl
    )

    set(APP_SOURCES ${ENTRY_FILE} ${APP_SOURCES})

    set(EXE_TARGET ${APP_NAME}_exe)

    add_executable(${EXE_TARGET} ${APP_SOURCES})

    set_target_properties(${EXE_TARGET} PROPERTIES OUTPUT_NAME ${APP_NAME})

    target_link_libraries(
        ${EXE_TARGET} PRIVATE $<TARGET_NAME_IF_EXISTS:${PROJECT_NAME}>
    )

    include(warnings)
    target_enable_warnings(${EXE_TARGET})

    target_compile_features(${EXE_TARGET} PRIVATE cxx_std_17)

    install(
        TARGETS ${EXE_TARGET}
        RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
        LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    )
endforeach ()
