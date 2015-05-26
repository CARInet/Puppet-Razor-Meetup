class profiles::dnsmasq (
        $config_entries,
        $tftp_root,
        $template = "dnsmasq.conf.erb",
	$package = "dnsmasq-2.65-1.el6.rfx.x86_64.rpm"
) {

	file { "/usr/local/src/${package}":
		source => "puppet:///modules/profiles/${package}"
	}

        package {'dnsmasq':
                ensure => present,
		provider => "rpm",
		source => "/usr/local/src/${package}",
		require => File["/usr/local/src/${package}"]
        }

        service { 'dnsmasq':
                ensure => running,
		enable => true,
                require => Package['dnsmasq']
        }

        file { 'tftp root':
                path => $tftp_root,
                ensure => directory
        }

        file { '/etc/dnsmasq.conf':
                ensure => file,
                content => template("profiles/${template}")
        }


}
