
if (NOT DEFINED ENV{GTEST_ROOT})
  message(FATAL_ERROR "'GTEST_ROOT' ENVIRONMENT-VARIABLE MUST BE DEFINED!")
endif()

# ---

set(CTEST_PROJECT_NAME "HelloGTest")

set(CTEST_CONFIGURATION_TYPE Release)

set(PREFIX_PATH
  $ENV{GTEST_ROOT}
)

if (PLATFORM STREQUAL osx)
  set(CTEST_CMAKE_GENERATOR "Ninja")
  set(TOOLCHAIN_FILE "$ENV{GTEST_ROOT}/cmake/osx.cmake")

elseif (PLATFORM STREQUAL ios)
  set(CTEST_CMAKE_GENERATOR "Xcode")
  set(TOOLCHAIN_FILE "$ENV{GTEST_ROOT}/cmake/ios.xcode.cmake")

elseif (PLATFORM STREQUAL android)
  set(CTEST_CMAKE_GENERATOR "Ninja")
  set(TOOLCHAIN_FILE "$ENV{GTEST_ROOT}/cmake/android.cmake")

elseif (PLATFORM STREQUAL emscripten)
  set(CTEST_CMAKE_GENERATOR "Ninja")
  set(TOOLCHAIN_FILE "$ENV{GTEST_ROOT}/cmake/emscripten.cmake")

else()
  message(FATAL_ERROR "UNSUPPORTED PLATFORM!")
endif()

set(CONFIGURE_ARGS "-DCMAKE_PREFIX_PATH=${PREFIX_PATH} -DCMAKE_TOOLCHAIN_FILE=${TOOLCHAIN_FILE}")