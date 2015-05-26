class roles::puppetmaster {

        class {'profiles::postgresql': }
        ->
        class {'profiles::rvm': }
        ->
        class {'profiles::razor_server': }
        ->
        class {'profiles::dnsmasq': }
        ->
        class {'profiles::puppetmaster': }

	include ::hosts
}
