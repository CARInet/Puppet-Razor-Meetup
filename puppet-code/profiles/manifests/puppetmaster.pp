class profiles::puppetmaster ()
{

        package { 'puppet-server':
                ensure => "present"
        } ->

        service { 'puppetmaster':
                ensure => 'running',
                enable => 'true',
        }

        $shared_ip = hiera("shared_ip")

        file_line { 'razor api':
                path => '/root/.bashrc',
                line => "export RAZOR_API=\"http://${shared_ip}:8080/api\""
        }

}

