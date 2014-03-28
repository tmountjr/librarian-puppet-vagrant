Exec { path => ["/bin/", "/sbin/", "/usr/bin/", "/usr/sbin"] }

class { 'apache': }

class { 'php':
	package => ['php5-cli', 'libapache2-mod-php5', 'php5-mcrypt'],
}

class { 'mysql::server':
	root_password => 'root',
	old_root_password => '',
	restart => true,
	service_enabled => true,
}

mysql::db { 'site_development':
	user => 'site_dev',
	password => 'site_development',
	host => 'localhost',
	grant => ['all'],
	require => Class['mysql::server']
}

php::module { 'mysql':
	require => [Class['mysql::server'], Class['php']],
}

# figure out why apache isn't serving php 
