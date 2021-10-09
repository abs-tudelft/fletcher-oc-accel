cmake_minimum_required(VERSION 3.14 FATAL_ERROR)

project(fletcher_oc-accel VERSION 0.0.0 LANGUAGES C CXX)

include(FetchContent)
FetchContent_Declare(cmake-modules
  GIT_REPOSITORY  https://github.com/abs-tudelft/cmake-modules.git
  GIT_TAG         master
)
FetchContent_MakeAvailable(cmake-modules)

include(CompileUnits)

# Attempt to find snap
find_library(SNAP osnap HINTS "$ENV{SNAP_ROOT}/software/lib")
if(SNAP)
  add_library(snap SHARED IMPORTED GLOBAL)
  set_target_properties(snap PROPERTIES IMPORTED_LOCATION ${SNAP})
  target_include_directories(snap INTERFACE "$ENV{SNAP_ROOT}/software/include")
else()
  message(FATAL_ERROR "SNAP not found. Please source snap_path.sh in the oc-accel repository...")
endif()

add_subdirectory(../fletcher/common/c c)

option(SNAP_SIM "Build oc-accel run-time in simulation mode." ON)
if (SNAP_SIM)
  message("Building fletcher_snap for simulation.")
else()
  add_definitions(-DSNAP_NSIM)
endif()

add_compile_unit(
  NAME fletcher::oc-accel
  TYPE SHARED
  PRPS
    C_STANDARD 99
  SRCS
    src/fletcher_oc-accel.c
  DEPS
    fletcher::c
    snap
)

compile_units()
