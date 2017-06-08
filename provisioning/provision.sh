#!/bin/bash

function do_install {
	if [ -n "$1" ]; then
	  WORKDIR="$1"
      dos2unix -q ${WORKDIR}/provision.sh
      source ${WORKDIR}/provision.sh ${WORKDIR}
	else
		warn do_install WHAT
		exit 1;
	fi
}

echo "Starting provisioning script..."
sed -i 's/^mesg n/tty -s \&\& mesg n/g' /root/.profile
. /root/.profile

apt-get -y update
apt-get -y install dos2unix

# Create a temp dir to work in, so dos2unix won't cause changes in the original files
TMPDIR=$(mktemp -dt "$(basename $0).XXXXXXXXXX")
trap 'rm -rf "${TMPDIR}"' EXIT
chmod o+rx ${TMPDIR}

cp -a /installers ${TMPDIR}

SRCDIR=${TMPDIR}/installers
echo working from source dir ${SRCDIR}

echo "Converting all installer files to unix format..."
find ${SRCDIR} -type f | xargs dos2unix -q


do_install ${SRCDIR}/locale

do_install ${SRCDIR}/dependencies

do_install ${SRCDIR}/apt-cacher
