line_width = 80
tab_size = 4
max_subgroups_hwrap = 2
max_pargs_hwrap = 2
separate_ctrl_name_with_space = True
dangle_parens = True
min_prefix_chars = 1
max_prefix_chars = 2
command_case = 'lower'
keyword_case = 'upper'
additional_commands = {
    'conan_add_remote': {
        'kwargs': {
            'INDEX': 1,
            'NAME': 1,
            'URL': 1
        }
    },
    'conan_check': {
        'flags': [
            'REQUIRED'
        ],
        'kwargs': {
            'VERSION': 1
        }
    },
    'conan_cmake_run': {
        'flags': [
            'BASIC_SETUP',
            'CMAKE_TARGETS',
            'KEEP_RPATHS',
            'NO_OUTPUT_DIRS',
        ],
        'kwargs': {
            'ARCH': 1,
            'BUILD': '+',
            'BUILD_TYPE': 1,
            'CONANFILE': 1,
            'ENV': '+',
            'GENERATORS': '+',
            'INSTALL_FOLDER': 1,
            'OPTIONS': '+',
            'PROFILE': '+',
            'PROFILE_AUTO': '+',
            'REQUIRES': '+',
            'SETTINGS': '+'
        }
    },
    'catch_discover_tests': {
        'kwargs': {
            'EXTRA_ARGS': '+',
            'PROPERTIES': '+',
            'TEST_PREFIX': 1,
            'TEST_SPEC': '+',
            'TEST_SUFFIX': 1,
            'TEST_LIST': 1,
            'WORKING_DIRECTORY': 1
        }
    }
}
