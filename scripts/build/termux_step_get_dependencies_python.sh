termux_step_get_dependencies_python() {
	if [ "$TERMUX_PKG_SETUP_PYTHON" = "true" ]; then
		# python pip setup
		termux_setup_python_pip

		# installing python modules
		if [ "$TERMUX_SKIP_DEPCHECK" = "false" ]; then
			if [ "$TERMUX_ON_DEVICE_BUILD" = "true" ]; then
				if [ -n "$TERMUX_PYTHON_TARGET_DEPS" ] || [ -n "$TERMUX_PYTHON_COMMOM_DEPS" ]; then
					pip3 install ${TERMUX_PYTHON_TARGET_DEPS//,/} ${TERMUX_PYTHON_COMMOM_DEPS//,/}
				fi
			else
				if [ -n "$TERMUX_PYTHON_BUILD_DEPS" ] || [ -n "$TERMUX_PYTHON_COMMOM_DEPS" ]; then
					build-pip install ${TERMUX_PYTHON_BUILD_DEPS//,/} ${TERMUX_PYTHON_COMMOM_DEPS//,/}
				fi
			fi
		fi

		# adding and setting values ​​to work properly with python modules
		export PYTHONPATH=$TERMUX_PREFIX/lib/python${TERMUX_PYTHON_VERSION}/site-packages
		export PYTHON_SITE_PKG=$TERMUX_PREFIX/lib/python${TERMUX_PYTHON_VERSION}/site-packages
		LDFLAGS+=" -lpython${TERMUX_PYTHON_VERSION}"
	fi
}
