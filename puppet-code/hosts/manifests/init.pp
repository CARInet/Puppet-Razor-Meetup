class hosts (
        $entries,
        $hosts_template = "hosts.erb"
){

        file {'/etc/hosts':
                ensure => file,
                owner => 'root',
                group => 'root',
                mode => '0644',
                content => template("hosts/${hosts_template}")
        }

}
