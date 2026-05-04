#!/bin/bash
set -e

mkdir build
cd build
export CMAKE_PREFIX_PATH=../../SDL/install
cmake -DSDLTTF_VENDORED=ON -DSDLTTF_SAMPLES=OFF \
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_OSX_DEPLOYMENT_TARGET=$MACOS_MIN \
      -DCMAKE_OSX_ARCHITECTURES='arm64;x86_64' \
      ../../../SDL_ttf/
cmake --build . --config Release -v
cmake --install . --config Release --prefix ../install -v
cd ..

# Remove the version suffix from the dylib's internal name
install_name_tool -id @rpath/libSDL3_ttf.dylib install/lib/libSDL3_ttf.dylib