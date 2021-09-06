cmake_minimum_required(VERSION 3.11)

project(install_dependency)
include(ExternalProject)

ExternalProject_Add(date
  GIT_REPOSITORY https://github.com/liu1009xf/test_lib.git
  GIT_TAG main
  INSTALL_DIR "${CMAKE_INSTALL_PREFIX}"
  CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR>
  TEST_COMMAND ""      # Disable test step
  UPDATE_COMMAND ""    # Disable source work-tree update
)