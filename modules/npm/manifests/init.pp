# Install npm
class npm (
	$config,
	$path = '/vagrant/extensions/npm',
) {
	if ( ! empty($config[disabled_extensions]) and 'chassis/npm' in $config[disabled_extensions] ) {
		exec { 'uninstall npm':
			path    => [ '/bin/', '/sbin/', '/usr/bin/', '/usr/sbin/' ],
			command => 'npm uninstall npm -g'
		}
	} else {
		exec { 'install npm':
			path    => [ '/bin/', '/sbin/', '/usr/bin/', '/usr/sbin/' ],
			command => 'npm install -g npm@latest',
			require => [ Class['nodejs'] ],
			unless  => 'which npm',
		}

		if ( $config[npm] and $config[npm][paths]) {
			install_npm { $config[npm][paths]: }
		}
	}
}


# Puppet 3.8 doesn't have the .each function and we need an alternative.
define install_npm {
	exec { "Installing npm ${name}":
		path      => [ '/bin/', '/sbin/', '/usr/bin/', '/usr/sbin/' ],
		cwd       => $name,
		command   => 'npm install',
		require   => [ Exec['install npm'] ],
		logoutput => true,
	}
}
