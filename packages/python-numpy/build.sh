TERMUX_PKG_HOMEPAGE=https://numpy.org/
TERMUX_PKG_DESCRIPTION="The fundamental package for scientific computing with Python"
TERMUX_PKG_LICENSE="BSD 3-Clause"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="1.24.1"
TERMUX_PKG_REVISION=1
TERMUX_PKG_SRCURL=git+https://github.com/numpy/numpy
TERMUX_PKG_DEPENDS="libandroid-complex-math, libc++, libopenblas, python"
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_UPDATE_TAG_TYPE="latest-release-tag"
TERMUX_PYTHON_COMMOM_DEPS="wheel, pybind11, Cython, pythran"
TERMUX_PYTHON_LDFLAGS="-landroid-complex-math -lm"
TERMUX_PYTHON_PIP_VARIAB="MATHLIB=m"
TERMUX_PKG_RM_AFTER_INSTALL="
bin/
"
