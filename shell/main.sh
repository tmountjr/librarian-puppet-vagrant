#!/bin/sh

PUPPET_DIR=/etc/puppet/

$(which git > /dev/null 2>&1)
FOUND_GIT=$?
if [ "$FOUND_GIT" -ne '0' ]; then
	echo 'Attempting to install git.'
	$(which apt-get > /dev/null 2>&1)
	FOUND_APT=$?
	$(which yum > /dev/null 2>&1)
	FOUND_YUM=$?

	if [ "${FOUND_YUM}" -eq '0' ]; then
		yum -q -y makecache
		yum -q -y install git
		echo 'Git installed.'
	elif [ "${FOUND_APT}" -eq '0' ]; then
		apt-get -q -y update
		apt-get -q -y install git
		echo 'Git installed.'
	else
		echo 'No package installer available. You may need to install Git manually.'
	fi
else
	echo 'Git found'
fi

if [ ! -d "$PUPPET_DIR" ]; then
	mkdir -p $PUPPET_DIR
fi
cp /vagrant/puppet/Puppetfile $PUPPET_DIR

if [ "$(gem search -i librarian-puppet)" = "false" ]; then
	sudo gem install librarian-puppet
	cd $PUPPET_DIR && librarian-puppet install --clean
else
	cd $PUPPET_DIR && librarian-puppet update
fi
