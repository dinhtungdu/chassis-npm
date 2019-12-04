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
  if is_hash($name) {
    exec { "Executing: ${name[command]} in ${name[path]}":
      path      => [ '/bin/', '/sbin/', '/usr/bin/', '/usr/sbin/' ],
      cwd       => $name[path],
      command   => $name[command],
      require   => [ Exec['install npm'] ],
      logoutput => true
    }
  } else {
    exec { "Executing: npm install in ${name}":
      path      => [ '/bin/', '/sbin/', '/usr/bin/', '/usr/sbin/' ],
      cwd       => $name,
      command   => 'npm install',
      require   => [ Exec['install npm'] ],
      logoutput => true
    }
  }
}
