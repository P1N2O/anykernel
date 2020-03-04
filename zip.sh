#!/bin/bash
#
# Build Kernels for lazy folks like @P1N2O
#
# Copyright (C) 2017-2020 Manuel Pinto
#
#       delta.manuelpinto.in

KERNEL_VER=$(sed -n '1p' version)
KERNEL_TOUCH=$(sed -n '2p' version)
KERNEL_OC=$(sed -n '3p' version)
BUILD_DATE=$(date -u +"%F")
FINAL_KERNEL_ZIP=Delta-Kernel-TEST_BUILD-${BUILD_DATE}.zip

if [ -f Image.gz-dtb ]
    then
    echo "Creating Kernel Zip"
    sed -i "1s/.*/TEST BUILD (${BUILD_DATE})/" version
    # Zip dir
    zip -r9 ${FINAL_KERNEL_ZIP} * -x .git README.md *placeholder zip.sh dtbs/\* kernel/\* modules/\* patch/\*
    # Save Kernel zip info
    SHA1=($(sha1sum ${FINAL_KERNEL_ZIP}))
    ZIP_SIZE=($(du -h ${FINAL_KERNEL_ZIP} | awk '{print $1}'))
    # Revert anykernel dir to original state
    rm -rf Image.gz-dtb
    sed -i "1s/.*/vX.Y/" version
    echo "${FINAL_KERNEL_ZIP} created!"
fi
