
set(IOS_ARCHS
  armv7
  arm64
  CACHE STRING "ios_archs"
)

set(IOS_DEPLOYMENT_TARGET 6.0
  CACHE STRING "ios_deployment_target"
)

# ---

set(CMAKE_OSX_SYSROOT iphoneos)
set(CMAKE_OSX_ARCHITECTURES ${IOS_ARCHS})
set(CMAKE_CXX_FLAGS "-miphoneos-version-min=${IOS_DEPLOYMENT_TARGET} -stdlib=libc++") # NECESSARY TO SPECIFY libc++, OTHERWISE libstdc++ WILL BE USED ON OLDER DEPLOYMENT-TARGETS

# ---

set(CMAKE_LIBRARY_ARCHITECTURE ios)
