@echo on

setlocal EnableDelayedExpansion

mkdir build
cd build

set "HOST=x86_64-w64-mingw32"
set "CC=%HOST%-gcc.exe"
set "CXX=%HOST%-g++.exe"
set "AR=%HOST%-gcc-ar.exe"
set "RANLIB=%HOST%-gcc-ranlib.exe"

cmake -G "MSYS Makefiles" ^
      %CMAKE_ARGS% ^
      -DCMAKE_BUILD_TYPE:STRING=Release ^
      -DCMAKE_CXX_STANDARD_LIBRARIES:STRING="-lpsapi" ^
      ..
if errorlevel 1 exit 1

cmake --build . -- -j%CPU_COUNT%
if errorlevel 1 exit 1

cmake --install .
if errorlevel 1 exit 1
