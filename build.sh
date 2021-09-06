#!/bin/bash

# This script can be called from anywhere and allows to build out of source.

# Determine script absolute path
SCRIPT_ABS_PATH=$(readlink -f ${BASH_SOURCE[0]})
SCRIPT_ABS_PATH=$(dirname ${SCRIPT_ABS_PATH})

# switch to root folder, where top-level CMakeLists.txt lives
ROOT=$(readlink -f ${SCRIPT_ABS_PATH}/)
cd $ROOT

# Choose build type
BUILD_TYPE=Release
# BUILD_TYPE=Debug

# Choose build type
BUILD_DIR=build

# Choose install folder
DEPENDENCY_DIR=dependency
INSTALL_DIR=dependency/install
CONFIG_DIR=lib/cmake/TestLib
# Options summary
echo ""
echo "BUILD_TYPE  =" ${BUILD_TYPE}
echo "BUILD_DIR   =" ${ROOT}/${BUILD_DIR}/
echo "INSTALL_DIR =" ${ROOT}/${INSTALL_DIR}/
echo "DTestLib_DIR=" ${ROOT}/${INSTALL_DIR}/${CONFIG_DIR}/
echo ""

if [ ! -d "${DTestLib_DIR}" ] 
then
    sh ${ROOT}/${DEPENDENCY_DIR}/install.sh
fi

# ------------------------------
# example_external (for testing)
# ------------------------------
printf "\n\n ----- example_external ----- \n\n"

# clean
rm -fr ${BUILD_DIR}
mkdir -p ${BUILD_DIR}

SO=`uname`
if [[ $SO == "Linux" ]]; then
    echo "Running on Linux"

    # cmake
    cmake \
        -S ${ROOT} \
        -B ${ROOT}/${BUILD_DIR} \
        -DCMAKE_BUILD_TYPE=${BUILD_TYPE} \
        -DTestLib_DIR="${ROOT}/${INSTALL_DIR}/${CONFIG_DIR}/"

    # compile
    cmake \
        --build ${ROOT}/${BUILD_DIR} \
        -j 8

else
    echo "Running on Windows"

    # cmake
    cmake \
        -S ${ROOT} \
        -B ${ROOT}/${BUILD_DIR} \
        -DATOM_DIR="${ROOT}/${INSTALL_DIR}/${CONFIG_DIR}/"

    # compile
    cmake \
        --build ${ROOT}/${BUILD_DIR} \
        --config ${BUILD_TYPE} \
        -j 8
fi


# run
BIN_PATH=${ROOT}/${BUILD_DIR}
echo ${BIN_PATH}/${BUILD_TYPE}/
if [ -d "${BIN_PATH}/${BUILD_TYPE}" ]; then  # multi-config generator
   BIN_PATH=${BIN_PATH}/${BUILD_TYPE}
fi
${BIN_PATH}/bar
