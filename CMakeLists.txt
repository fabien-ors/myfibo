##########################################################################################
#
#                      MYFIBO C++ Library and Wrappers
#
#                   Author: Fabien Ors (MINES Paris - PSL) 
#                   License: MIT
#                   Date: June 2022
#
#
# 1. Configure project :
#
#                      cmake -Bbuild -H.
#
#
# 2a. Build static library (and install Python package)
# 
#   GCC / MinGW =>     cmake --build build --target python_install
#   MSVC        =>     cmake --build build --target python_install --config Release
#
#
# 2b. Build and install shared library (and don't build Python package)
#
#   GCC / MinGW =>     cmake --build build --target install
#   MSVC        =>     cmake --build build --target install --config Release
#
#
# 3. Execute non-regression tests (C++, Python and R)
#
#   GCC / MinGW =>     cmake --build build --target check
#   MSVC        =>     cmake --build build --target check --config Release
#
#
# Note: See shortcuts for 'make' users in Makefile file
#

# For recent UseSWIG
cmake_minimum_required(VERSION 3.20)

# Verbose makefiles
#set(CMAKE_VERBOSE_MAKEFILE ON)

# Define project here
project(myfibo
  VERSION      0.0.14
  DESCRIPTION  "Fibonacci simple C++ library and packages"
  HOMEPAGE_URL "https://github.com/fabien-ors/myfibo"
  LANGUAGES    C CXX # Enable C language for third party libraries
)

####################################################
## CONFIGURATION

# Get the project date
string(TIMESTAMP ${PROJECT_NAME}_DATE "%Y/%m/%d - %H:%M")

# Convert project name to uppercase
string(TOUPPER ${PROJECT_NAME} PROJECT_NAME_UP)

# Fix version.h automatically
configure_file(version.h.in version.h)

# Activate verbose mode
#set(CMAKE_VERBOSE_MAKEFILE ON)

# Options
option(BUILD_PYTHON "Build Python package" ON)
option(BUILD_R      "Build R package"      ON)
if (MINGW)
  set(BUILD_PYTHON OFF)
endif()
if (MSVC)
  set(BUILD_R OFF)
endif()
message(STATUS "BUILD_PYTHON=" ${BUILD_PYTHON})
message(STATUS "BUILD_R="      ${BUILD_R})

# Universal binary for Mac (TODO : doesn't work for customized R)
#set(CMAKE_OSX_ARCHITECTURES "x86_64;arm64" CACHE STRING "Build architectures for Mac OS X" FORCE)

####################################################
## BUILD & INSTALL

include(cmake/cpp.cmake)
# TODO : Add doxygen feature
#include(cmake/doxygen.cmake)
include(cmake/install.cmake)


####################################################
## PACKAGES

add_subdirectory(python)
add_subdirectory(r)

####################################################
## TESTING

# Add non-regression test target
include(CTest)
enable_testing()

add_subdirectory(tests)
