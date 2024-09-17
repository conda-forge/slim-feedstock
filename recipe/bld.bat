@echo on

setlocal EnableDelayedExpansion

mkdir build
cd build

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
