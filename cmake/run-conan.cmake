option(RUN_CONAN "Run conan install automatically" OFF)

if (RUN_CONAN)
    if (NOT EXISTS "${CMAKE_BINARY_DIR}/conan.cmake")
        message(
            STATUS
                "Downloading conan.cmake from https://github.com/conan-io/cmake-conan"
        )

        file(
            DOWNLOAD
            # Using develop because master doesn't work with msvc currently
            "https://github.com/conan-io/cmake-conan/raw/develop/conan.cmake"
            "${CMAKE_BINARY_DIR}/conan.cmake"
        )
    endif ()

    include(${CMAKE_BINARY_DIR}/conan.cmake)

    conan_check(REQUIRED)
    conan_add_remote(
        NAME bincrafters
        INDEX 1
        URL https://api.bintray.com/conan/bincrafters/public-conan
    )
    conan_cmake_run(CONANFILE conanfile.txt BUILD missing)
endif ()
