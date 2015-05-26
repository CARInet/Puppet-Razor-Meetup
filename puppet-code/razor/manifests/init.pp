class razor (
        $shared_ip,
        $db_user,
        $db_password,
        $razor_shared = '/var/lib/razor',
        $rest_client_options    = '',
){

	Yaml_setting {
		require => Package['razor-server']
	}

	file {$razor_shared:
		ensure => directory
	}

        file {"${razor_shared}/repo-store":
		ensure => directory,
		require => File[$razor_shared]
        }

        package {'ruby-devel':
                ensure => present,
        }

        package {'razor-server':
                ensure => present,
		require => Package['ruby-devel']
        }

        package {'rest-client':
                ensure => present,
                install_options => $rest_client_options,
                provider => 'gem',
		require => Package['razor-server']
        }

        package {'razor-client':
                ensure => 'latest',
                provider => 'gem',
		require => Package['razor-server']
        }

        yaml_setting {'razor-db-url':
                target => '/etc/razor/config.yaml',
                key => 'production/database_url',
                value => "jdbc:postgresql://${shared_ip}/razor?user=${db_user}&password=${db_password}",
        }

        yaml_setting {'razor-protect-new-nodes':
                target => '/etc/razor/config.yaml',
                key => 'all/protect_new_nodes',
                value => false,
        }

        yaml_setting {'razor-repo-store':
                target => '/etc/razor/config.yaml',
                key => 'all/repo_store_root',
                value => "${razor_shared}/repo-store",
        }

        service {'razor-server':
                ensure => running,
		enable => true,
                require => [Yaml_setting['razor-db-url'], Package['razor-server'], File["${razor_shared}/repo-store"]]
        }
}
