#! /bin/bash

conan install .. --build missing -s build_type=${BUILD_TYPE} -pr default -pr ../tools/conan/build_tools -g virtualbuildenv

source ./activate_build.sh
source ./activate.sh

which cmake
cmake --version

cmake .. -GNinja -DCMAKE_BUILD_TYPE:STRING="${BUILD_TYPE}" -DBUILD_TESTS=ON
cmake --build . --config ${BUILD_TYPE}
ctest --output-on-failure -C ${BUILD_TYPE}
