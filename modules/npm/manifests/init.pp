class npm (
	$config,
	$path = "/vagrant/extensions/npm",
) {
	exec { 'install npm':
		path        => [ '/bin/', '/sbin/', '/usr/bin/', '/usr/sbin/' ],
		command     => 'npm install -g npm@latest',
		require     => [ Class['nodejs'] ],
		unless  => 'which npm',
	}
}
