TERMUX_PKG_HOMEPAGE=https://gi.readthedocs.io/
TERMUX_PKG_DESCRIPTION="Uniform machine readable API"
TERMUX_PKG_LICENSE="LGPL-2.0, GPL-2.0"
TERMUX_PKG_MAINTAINER="@termux"
_MAJOR_VERSION=1.74
TERMUX_PKG_VERSION=${_MAJOR_VERSION}.0
TERMUX_PKG_REVISION=4
TERMUX_PKG_SRCURL=https://download.gnome.org/sources/gobject-introspection/${_MAJOR_VERSION}/gobject-introspection-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=347b3a719e68ba4c69ff2d57ee2689233ea8c07fc492205e573386779e42d653
TERMUX_PKG_DEPENDS="glib, libffi"
TERMUX_PKG_SUGGESTS="g-ir-scanner"
TERMUX_PKG_DISABLE_GIR=false
TERMUX_PYTHON_COMMOM_DEPS="wheel"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-Dcairo_libname=libcairo-gobject.so
-Dpython=python
-Dbuild_introspection_data=true
"

termux_step_pre_configure() {
	termux_setup_gir
	TERMUX_PKG_EXTRA_CONFIGURE_ARGS+="
		-Dgi_cross_binary_wrapper=$GI_CROSS_LAUNCHER
		"
	unset GI_CROSS_LAUNCHER
	if [ "$TERMUX_ON_DEVICE_BUILD" = "false" ]; then
		TERMUX_PKG_EXTRA_CONFIGURE_ARGS+="
			-Dgi_cross_use_prebuilt_gi=true
			-Dgi_cross_ldd_wrapper=$(command -v ldd)
			"
	fi

	echo "Applying meson-python.diff"
	sed "s%@PYTHON_VERSION@%$TERMUX_PYTHON_VERSION%g" \
		$TERMUX_PKG_BUILDER_DIR/meson-python.diff | patch --silent -p1

	CPPFLAGS+="
		-I$TERMUX_PREFIX/include/python${TERMUX_PYTHON_VERSION}
		-I$TERMUX_PREFIX/include/python${TERMUX_PYTHON_VERSION}/cpython
		"
}
