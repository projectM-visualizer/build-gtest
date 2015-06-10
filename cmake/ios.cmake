set (
  IOS_ARCHS
  "armv7;arm64"
  CACHE STRING "ios_archs"
)

set (
  IOS_DEPLOYMENT_TARGET
  6.0
  CACHE STRING "ios_deployment_target"
)

# ---

set (CMAKE_OSX_SYSROOT iphoneos
  CACHE STRING "cmake_osx_sysroot/ios"
)

set (CMAKE_OSX_ARCHITECTURES
  ${IOS_ARCHS}
  CACHE STRING "cmake_osx_architectures/ios"
)

set (CMAKE_CXX_FLAGS
  "-miphoneos-version-min=${IOS_DEPLOYMENT_TARGET} -stdlib=libc++"
  CACHE STRING "cmake_cxx_flags/ios"
)