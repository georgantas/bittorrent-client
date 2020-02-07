#!/bin/bash

# https://sipb.mit.edu/doc/safe-shell/
set -euo pipefail

## INSTALL GTEST ON TRAVIS ##
cd /usr/src/gtest
cmake CMakeLists.txt
make
cp *.a /usr/lib
ln -s /usr/lib/libgtest.a /usr/local/lib/gtest/libgtest.a
ln -s /usr/lib/libgtest_main.a /usr/local/lib/gtest/libgtest_main.a
cd -
## END INSTALL GTEST ON TRAVIS ##


mkdir -p build && cd build
cmake -DCODE_COVERAGE=ON -DCMAKE_BUILD_TYPE=Debug ..
# $(nproc) prints number of processing units available
cmake --build . --config Debug -- -j $(nproc)
ctest -j $(nproc) --output-on-failure
./unittests
