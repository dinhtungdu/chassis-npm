# Install npm
class npm (
	$config,
	$path = '/vagrant/extensions/npm',
) {
	exec { 'install npm':
		path    => [ '/bin/', '/sbin/', '/usr/bin/', '/usr/sbin/' ],
		command => 'npm install -g npm@latest',
		require => [ Class['nodejs'] ],
		unless  => 'which npm',
	}

	# Puppet 3.8 doesn't have the .each function and we need an alternative.
	define install {
		exec { "Installing npm ${name}":
			path    => [ '/bin/', '/sbin/', '/usr/bin/', '/usr/sbin/' ],
			cwd     => $name,
			command => 'npm install',
			require => [ Exec['install npm'] ],
		}
	}

	if ( $config[npm] and $config[npm][paths]) {
		install { $config[npm][paths]: }
	}
}
