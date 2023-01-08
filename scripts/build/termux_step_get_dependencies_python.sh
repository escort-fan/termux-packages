termux_step_get_dependencies_python() {
	if [ "$TERMUX_PKG_SETUP_PYTHON" = "true" ]; then
		# python pip setup
		termux_setup_python_pip

		# installing python modules
		LDFLAGS+=" -lpython${TERMUX_PYTHON_VERSION}"
		if [ -n "$TERMUX_PYTHON_LDFLAGS" ]; then
			LDFLAGS+=" $TERMUX_PYTHON_LDFLAGS"
		fi
		if [ "$TERMUX_SKIP_DEPCHECK" = "false" ]; then
			local pip
			local pip_pkgs="$TERMUX_PYTHON_COMMOM_DEPS, "
			if [ "$TERMUX_ON_DEVICE_BUILD" = "true" ]; then
				pip="pip3"
				pip_pkgs+="$TERMUX_PYTHON_TARGET_DEPS"
			else
				pip="build-pip"
				pip_pkgs+="$TERMUX_PYTHON_BUILD_DEPS"
			fi
			for i in ${pip_pkgs//,/} ; do
				[ ! "$TERMUX_QUIET_BUILD" = true ] && echo "Installing the dependency python module $i if necessary..."
				if ! termux_check_package_in_built_packages_list "python-$i"; then
					$pip install $(test "${TERMUX_FORCE_BUILD_DEPENDENCIES}" = "true" && echo "-I" || true) "$i"
					termux_add_package_to_built_packages_list "python-$i"
				else
					[ ! "$TERMUX_QUIET_BUILD" = true ] && echo "Skipping the already installed dependency python module $i"
				fi
			done
		fi

		# adding and setting values ​​to work properly with python modules
		export PYTHONPATH=$TERMUX_PREFIX/lib/python${TERMUX_PYTHON_VERSION}/site-packages
		export PYTHON_SITE_PKG=$TERMUX_PREFIX/lib/python${TERMUX_PYTHON_VERSION}/site-packages
	fi
}
