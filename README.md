# projectname

![Build Status](https://github.com/username/projectname/workflows/CI/badge.svg)
![Clang-Format Status](https://github.com/username/projectname/workflows/clang-format/badge.svg)
![License](https://img.shields.io/github/license/username/projectname)

description

## Building

### Prerequisites

* C++17 compliant compiler
* [CMake 3.12+](https://cmake.org/download/)
* [Conan](https://conan.io/downloads.html)

### Setting up

```sh
git clone https://github.com/username/projectname
cd projectname
```

```sh
mkdir build
cd build
```

### Makefile generators (Make, Ninja, etc.)

```sh
cmake .. -GNinja -DCMAKE_BUILD_TYPE=Release -DRUN_CONAN=ON
cmake --build .
```

### Multi generators (Visual Studio, etc.)

```sh
cmake .. -G "Visual Studio 16 2019" -DRUN_CONAN=ON
cmake --build . --config Release
```

### CMake options

|       Option       | Default | Description                        |
| :----------------: | :-----: | ---------------------------------- |
|     RUN_CONAN      |   OFF   | Runs `conan install` automatically |
|    BUILD_TESTS     |   OFF   | Builds the tests                   |
| WARNINGS_AS_ERRORS |   OFF   | Treat compiler warnings as errors  |

## Authors

* [@username](https://github.com/username)

See also the list of [contributors](https://github.com/username/projectname) who participated in this project.
