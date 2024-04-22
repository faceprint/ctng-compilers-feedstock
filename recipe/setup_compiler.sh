#!/bin/bash

if [[ ! -d  $SRC_DIR/cf-compilers ]]; then
  if [[ "${build_platform}" == "${target_platform}" ]]; then
    # Use new compilers instead of relying on ones from the docker image
    conda create -p $SRC_DIR/cf-compilers gcc gfortran gxx binutils -c conda-forge --yes --quiet
  fi

  if [[ "${build_platform}" != "${target_platform}" ]]; then
    conda create -p $SRC_DIR/cf-compilers -c conda-forge \
      "gcc_impl_${target_platform}=${binutils_version}.*" \
      "gxx_impl_${target_platform}=${binutils_version}.*" \
      "gcc_impl_${cross_target_platform}=${binutils_version}.*" \
      "gxx_impl_${cross_target_platform}=${binutils_version}.*" \
      "gfortran_impl_${cross_target_platform}=${binutils_version}.*"
  fi
fi

export PATH=$SRC_DIR/cf-compilers/bin:$PATH
