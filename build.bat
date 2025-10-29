@echo off

setlocal EnableDelayedExpansion

if not exist SPIRV-Reflect\NUL (
    git clone --recurse-submodules https://github.com/KhronosGroup/SPIRV-Reflect --depth=1
)

set binaries_dir=build

echo Configuring build...
cmake . -B %binaries_dir% -DSPIRV_REFLECT_EXECUTABLE=OFF -DSPIRV_REFLECT_STATIC_LIB=ON -DCMAKE_BUILD_TYPE=Release

echo Building project...
make -C %binaries_dir%

copy /y %binaries_dir%\spirv-reflect-static.lib .\spirv.lib

echo Build completed successfully!
