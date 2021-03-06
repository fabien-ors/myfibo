# This Makefile is just a shortcut to cmake commands for make users (Linux-gcc or Windows-msys)
#
# Call 'make' with one of this target:
# 
# C++ Library:
#  - shared         Build myfibo shared library
#  - static         Build myfibo static library
#  - build_tests    Build non-regression tests executables
#  - doxygen        Build doxygen documentation [optional] [TODO]
#  - install        Install myfibo shared library [and html doxymentation]
#  - uninstall      Uninstall myfibo shared library [and html doxymentation]
#
# Python wrapper (only for Linux-gcc):
#  - python_doc     Build python package documentation [optional] [TODO]
#  - python_build   Build python wrapper [and its documentation]
#  - python_install Install python package [and its documentation]
#  - python_upload  Build python package distribution and upload to PyPi [and its documentation] [TODO]
#
# R wrapper:
#  - r_doc          Build R package documentation [optional] [TODO]
#  - r_build        Build R wrapper [and its documentation]
#  - r_install      Install R package [and its documentation]
#  - r_upload       Build R package distribution and upload to CRAN-like [and its documentation] [TODO]
#
# Non-regression tests:
#  - check_cpp      Execute non-regression tests (cpp)
#  - check_py       Execute non-regression tests (python)
#  - check_r        Execute non-regression tests (R)
#  - check          Execute non-regression tests (cpp + python + R)
#
# Clean:
#  - clean          Clean generated files
#  - clean_all      Clean the build directory
#
# You can use the following variables:
#
#  - DEBUG=1            Build the debug version of the library and tests (default =0)
#  - N_PROC=N           Use more CPUs for building procedure (default =1)
#  - BUILD_DIR=<path>   Define a specific build directory (default =build[_msys])
#
# Usage example:
#
#  make check N_PROC=2
#

ifeq ($(OS),Windows_NT)
  GENERATOR = -G"MSYS Makefiles"
else
  GENERATOR = -G"Unix Makefiles"
endif

ifeq ($(DEBUG), 1)
  FLAVOR = Debug
 else
  FLAVOR = Release 
endif

ifndef BUILD_DIR
  ifeq ($(OS),Windows_NT)
    BUILD_DIR = build_msys
  else
    BUILD_DIR = build
  endif
endif

ifdef N_PROC
  ifeq ($(OS),Windows_NT)
    # Otherwise, undefined reference when compiling (don't know why)
    N_PROC_OPT = -j1
  else
    N_PROC_OPT = -j$(N_PROC)
  endif
else
  N_PROC_OPT = -j1
endif



.PHONY: all cmake static shared build_tests doxygen install uninstall

all: shared install

cmake:
	@cmake -DCMAKE_BUILD_TYPE=$(FLAVOR) -B$(BUILD_DIR) -H. $(GENERATOR)

static: cmake
	@cmake --build $(BUILD_DIR) --target static -- --no-print-directory $(N_PROC_OPT)

shared: cmake
	@cmake --build $(BUILD_DIR) --target shared -- --no-print-directory $(N_PROC_OPT)

build_tests: cmake
	@cmake --build $(BUILD_DIR) --target build_tests -- --no-print-directory $(N_PROC_OPT)

doxygen: cmake
	@echo "Target doxygen not yet implemented"

install: cmake
	@cmake --build $(BUILD_DIR) --target install -- --no-print-directory $(N_PROC_OPT)

uninstall: 
	@cmake --build $(BUILD_DIR) --target uninstall -- --no-print-directory $(N_PROC_OPT)



.PHONY: python_doc python_build python_install python_upload

python_doc: cmake
	@echo "Target python_doc not yet implemented"

python_build: cmake
	@cmake --build $(BUILD_DIR) --target python_build -- --no-print-directory $(N_PROC_OPT)

python_install: cmake
	@cmake --build $(BUILD_DIR) --target python_install -- --no-print-directory $(N_PROC_OPT)

python_upload: cmake
	@echo "Target python_upload not yet implemented"



.PHONY: r_doc r_build r_install r_upload

r_doc: cmake
	@echo "Target r_doc not yet implemented"

r_build: cmake
	@cmake --build $(BUILD_DIR) --target r_build -- --no-print-directory $(N_PROC_OPT)

r_install: cmake
	@cmake --build $(BUILD_DIR) --target r_install -- --no-print-directory $(N_PROC_OPT)

r_upload: cmake
	@echo "Target r_upload not yet implemented"



.PHONY: check_cpp check_py check_r check

check_cpp: cmake
	@CTEST_OUTPUT_ON_FAILURE=1 cmake --build $(BUILD_DIR) --target check_cpp -- --no-print-directory $(N_PROC_OPT)

check_py: cmake
	@CTEST_OUTPUT_ON_FAILURE=1 cmake --build $(BUILD_DIR) --target check_py -- --no-print-directory $(N_PROC_OPT)

check_r: cmake
	@CTEST_OUTPUT_ON_FAILURE=1 cmake --build $(BUILD_DIR) --target check_r -- --no-print-directory $(N_PROC_OPT)

check: cmake
	@CTEST_OUTPUT_ON_FAILURE=1 cmake --build $(BUILD_DIR) --target check -- --no-print-directory $(N_PROC_OPT)



.PHONY: clean clean_all

clean: 
	@cmake --build $(BUILD_DIR) --target clean -- --no-print-directory $(N_PROC_OPT)

clean_all:
	@rm -rf $(BUILD_DIR)

