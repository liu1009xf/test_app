#!/usr/bin/env bash

set -e

Build_Config=Release
ATOM_ROOT="$(git rev-parse --show-toplevel)"
BUILD_DIR="${ATOM_ROOT}/dependency/build"
INSTALL_DIR="${ATOM_ROOT}/dependency/install"

rm -rf "${INSTALL_DIR}" "${BUILD_DIR}"
mkdir -p "${INSTALL_DIR}" "${BUILD_DIR}"
cd "${BUILD_DIR}"

cmake "${ATOM_ROOT}/dependency" -DCMAKE_INSTALL_PREFIX="${INSTALL_DIR}" "${@}" 
cmake --build "${BUILD_DIR}" --config ${Build_Config} 

echo "************************************************************************"
echo " Add '${INSTALL_DIR}' to 'CMAKE_PREFIX_PATH' When Setting up atom_core  "
echo "************************************************************************"
