#!/bin/bash -e
#
# Copyright (c) 2013 Robert Nelson <robertcnelson@gmail.com>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

SYST=$(uname -n)
HOST_ARCH=$(uname -m)
TIME=$(date +%Y-%m-%d)

DIR="$PWD"

run_project () {
	/bin/bash -e "${DIR}/scripts/install_dependencies.sh" || { exit 1 ; }
	/bin/bash -e "${DIR}/scripts/debootstrap.sh" || { exit 1 ; }
	/bin/bash -e "${DIR}/scripts/chroot.sh" || { exit 1 ; }
}

tempdir=$(mktemp -d)

cat > ${DIR}/.project <<-__EOF__
	tempdir="${tempdir}"
	distro="debian"

	release="squeeze"
	dpkg_arch="armel"

	#apt_proxy="192.168.0.10:3142/"
	apt_proxy="rcn-ee.homeip.net:3142/"

__EOF__

run_project

#tempdir=$(mktemp -d)

#cat > ${DIR}/.project <<-__EOF__
#	tempdir="${tempdir}"
#	distro="debian"
#
#	release="wheezy"
#	dpkg_arch="armhf"
#
#	#apt_proxy="192.168.0.10:3142/"
#	apt_proxy="rcn-ee.homeip.net:3142/"
#
#__EOF__
#
#run_project

#