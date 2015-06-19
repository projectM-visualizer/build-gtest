
if (NOT CMAKE_GENERATOR STREQUAL "Xcode")
  message(FATAL_ERROR "UNSUPPORTED GENERATOR!")
endif()

set(IOS_ARCHS
  armv7
  arm64
  CACHE STRING "ios_archs"
)

set(IOS_DEPLOYMENT_TARGET 6.0
  CACHE STRING "ios_deployment_target"
)

# ---

macro (SET_ARCHS archs)
  set(VALID_ARCHS "")

  foreach (arch ${archs})
    set(VALID_ARCHS "${arch} ${VALID_ARCHS}")
  endforeach()

  set(CMAKE_XCODE_ATTRIBUTE_VALID_ARCHS "${VALID_ARCHS}")
  set(CMAKE_XCODE_ATTRIBUTE_ONLY_ACTIVE_ARCH NO) # NECESSARY WHEN SEVERAL ARCHITECTURES MUST BE BUILT
endmacro()

# ---

set(CMAKE_MACOSX_BUNDLE YES) # NECESSARY, OTHERWISE add_executable() IN CMakeLists.txt WON'T HAVE ANY EFFECT

set(CMAKE_OSX_SYSROOT iphoneos)
set(CMAKE_XCODE_ATTRIBUTE_CODE_SIGN_IDENTITY "iPhone Developer")

SET_ARCHS("${IOS_ARCHS}")

set(CMAKE_XCODE_ATTRIBUTE_TARGETED_DEVICE_FAMILY "1,2")
set(CMAKE_XCODE_ATTRIBUTE_IPHONEOS_DEPLOYMENT_TARGET ${IOS_DEPLOYMENT_TARGET})
set(CMAKE_XCODE_ATTRIBUTE_CLANG_CXX_LIBRARY "libc++")
set(CMAKE_XCODE_ATTRIBUTE_CLANG_CXX_LANGUAGE_STANDARD "c++11")

if (PROJECT_NAME STREQUAL "CMAKE_TRY_COMPILE")
  set(MACOSX_BUNDLE_GUI_IDENTIFIER foo.tmp)
  set(MACOSX_BUNDLE_EXECUTABLE_NAME tmp)

else()
  set(CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}") # TRICKY, BUT THE ONLY(?) WAY TO INTEGRATE A CUSTOM Info.plist
  set(MACOSX_BUNDLE_GUI_IDENTIFIER foo.${PROJECT_NAME})
  set(MACOSX_BUNDLE_EXECUTABLE_NAME ${PROJECT_NAME})
endif()

# ---

set(CMAKE_LIBRARY_ARCHITECTURE ios)

if (DEFINED RUN)
  if (NOT PROJECT_NAME STREQUAL CMAKE_TRY_COMPILE)
    configure_file(${CMAKE_CURRENT_LIST_DIR}/run/ios.sh.in run)
  endif()
endif()
