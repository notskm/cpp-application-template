# projectname

![Build Status](https://github.com/username/projectname/workflows/CI/badge.svg)
![License](https://img.shields.io/github/license/username/projectname)

description

## Building

### Prerequisites

* C++17 compliant compiler
* [Conan 1.17+](https://conan.io/)

### Setting up

Clone the repository and cd into it

```sh
git clone https://github.com/username/projectname
cd projectname
```

Make a build folder and cd into it

```sh
mkdir build
cd build
```

Set up conan remotes

```sh
conan remote add bincrafters https://api.bintray.com/conan/bincrafters/public-conan
```

Install the dependencies

```sh
conan install .. --build missing -s build_type=Release -pr default -pr ../tools/conan/build_tools
```

Activate virtualenv

```sh
# bash:
source activate.sh
```

```sh
# cmd:
./activate.bat
```

```sh
# powershell:
./activate.ps1
```

### Makefile generators (Make, Ninja, etc.)

```sh
cmake .. -GNinja -DCMAKE_BUILD_TYPE=Release
cmake --build .
```

### Multi generators (Visual Studio, etc.)

```sh
cmake .. -G "Visual Studio 16 2019"
cmake --build . --config Release
```

## Authors

* [@username](https://github.com/username)

See also the list of [contributors](https://github.com/username/projectname) who participated in this project.
