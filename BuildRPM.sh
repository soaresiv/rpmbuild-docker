#!/bin/bash
source /external/shell-logger/shell-logger

declare -r src_dir="/code"

#Setup Package info
declare -r package_spec_name="hello-world.spec"
declare -r package_path_to_spec_file="${src_dir}/${package_spec_name}"
declare -r package_name="Hello-world"
declare -r package_release="10"
declare -r package_version="5"

information "PACKAGE:   ${package_name}"
information "RELEASE:   ${package_release}"
information "VERSION:   ${package_version}"

if [ ! -f "${package_path_to_spec_file}" ]; then
	err "Missing ${package_path_to_spec_file}"
	exit 1
fi

#Setup RPM Workdir
rpmdev-setuptree

cp -v "${package_path_to_spec_file}" "${HOME}/rpmbuild/SPECS/"

declare -r package_full_name="${package_name}-${package_version}-${package_release}"

rpmbuild -bb \
	--define="package_name ${package_name}" \
	--define="package_release ${package_release}" \
	--define="package_version ${package_version}" \
	"${HOME}/rpmbuild/SPECS/${package_spec_name}" &>"/artifacts/${package_full_name}_build.log"

exit_status=$?

[[ $exit_status -ne 0 ]] && err "rpmbuild error. Logs on artifacts/${PACKAGE}_build.log"

# copy the rpms to the artifact directory, for jenkins.
if [[ -d /artifacts ]]; then
	cp --force ${HOME}/rpmbuild/RPMS/x86_64/*.rpm /artifacts
fi

exit 0
