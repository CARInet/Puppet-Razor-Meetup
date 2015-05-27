class profiles::vm-demo {

	package { 'httpd':
		ensure => present
	}

	service { 'httpd':
		ensure => "running",
		enable => true,
		require => Package['httpd']
	}

	file { '/var/www/html/index.html':
		ensure => present,
                content => template("profiles/testpage.html.erb")
	}	

}
