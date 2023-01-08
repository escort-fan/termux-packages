TERMUX_PKG_HOMEPAGE=https://github.com/apache/arrow
TERMUX_PKG_DESCRIPTION="Python library for Apache Arrow"
TERMUX_PKG_LICENSE="Apache-2.0"
TERMUX_PKG_MAINTAINER="@termux"
# Align the version with `libarrow-cpp` package.
TERMUX_PKG_VERSION=10.0.1
TERMUX_PKG_REVISION=1
TERMUX_PKG_SRCURL=https://github.com/apache/arrow/archive/refs/tags/apache-arrow-${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=28c3e0402bc1c3c1e047b6e26cedb8d1d89b2b9497d576af24b0b700eef11701
TERMUX_PKG_DEPENDS="libarrow-cpp, libc++, python"
TERMUX_PKG_BUILD_DEPENDS="python-numpy"
TERMUX_PYTHON_COMMOM_DEPS="Cython, wheel"

TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DPYARROW_WITH_DATASET=ON
-DPYARROW_WITH_HDFS=ON
-DPYTHON_EXECUTABLE=python
-DPYTHON_INCLUDE_DIRS=$TERMUX_PREFIX/include/python${TERMUX_PYTHON_VERSION}
-DPYTHON_OTHER_LIBS=
-DNUMPY_INCLUDE_DIRS=$TERMUX_PREFIX/lib/python${TERMUX_PYTHON_VERSION}/site-packages/numpy/core/include
-DARROW_PKG_CONFIG_INCLUDEDIR=$TERMUX_PREFIX/include
-DARROW_PKG_CONFIG_LIBDIR=$TERMUX_PREFIX/lib
"

termux_step_pre_configure() {
	TERMUX_PKG_SRCDIR+="/python/pyarrow/src"
}
