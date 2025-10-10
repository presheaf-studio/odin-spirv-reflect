#!/usr/bin/env bash

set -e

[ -d SPIRV-Reflect ] || git clone https://github.com/KhronosGroup/SPIRV-Reflect --depth 1

echo "Building SPIRV-Reflect.."
cd SPIRV-Reflect
cmake . -B build -DSPIRV_REFLECT_EXECUTABLE=OFF -DSPIRV_REFLECT_STATIC_LIB=ON
if [ $(uname -s) = 'Darwin' ]; then
    make -j$(sysctl -n hw.ncpu) -C build
    LIB_EXT=darwin
else
    make -j$(nproc) -C build
    LIB_EXT=linux
fi
#
cp build/libspirv-reflect-static.a ../spirv.$LIB_EXT.a
