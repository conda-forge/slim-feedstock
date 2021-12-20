setlocal EnableDelayedExpansion

mkdir build
cd build

:: Work around bug in mingw (we're stuck at gcc 5.3.0).
:: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=52991
set EXTRA_FLAGS="-mno-ms-bitfields"

cmake -G "MSYS Makefiles" ^
      -DCMAKE_INSTALL_PREFIX:PATH="%LIBRARY_PREFIX%" ^
      -DCMAKE_PREFIX_PATH:PATH="%LIBRARY_PREFIX%" ^
      -DCMAKE_BUILD_TYPE:STRING=Release ^
      -DCMAKE_CXX_STANDARD_LIBRARIES:STRING="-lpsapi" ^
      -DCMAKE_C_FLAGS="%EXTRA_FLAGS%" ^
      -DCMAKE_CXX_FLAGS="%EXTRA_FLAGS%" ^
      ..
if errorlevel 1 exit 1

cmake --build . -- -j%CPU_COUNT%
if errorlevel 1 exit 1

cmake --install .
if errorlevel 1 exit 1
