termux_step_get_dependencies_python() {
	if [ "$TERMUX_PKG_SETUP_PYTHON" = "true" ]; then
		# python pip setup
		termux_setup_python_pip

		# installing python modules
		if [ "$TERMUX_SKIP_DEPCHECK" = "false" ] && [ -n "$TERMUX_PYTHON_DEPENDS" ]; then
			if [ "$TERMUX_ON_DEVICE_BUILD" = "true" ]; then
				pip3 install ${TERMUX_PYTHON_DEPENDS//,/}
			else
				build-pip install ${TERMUX_PYTHON_DEPENDS//,/}
			fi
		fi

		# adding and setting values ​​to work properly with python modules
		export PYTHONPATH=$TERMUX_PREFIX/lib/python${TERMUX_PYTHON_VERSION}/site-packages
		export PYTHON_SITE_PKG=$TERMUX_PREFIX/lib/python${TERMUX_PYTHON_VERSION}/site-packages
		LDFLAGS+=" -lpython${TERMUX_PYTHON_VERSION}"
	fi
}
