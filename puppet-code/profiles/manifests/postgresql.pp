class profiles::postgresql(
        $datadir,
        $listen,
        $password,
        $hba_rules,
        $user = 'razor',
)
{

        class { 'postgresql::globals':
                manage_package_repo => true,
                confdir => $datadir,
                version             => '9.2'
        }

        class {'postgresql::server':
                service_enable => true,
                datadir => $datadir,
                listen_addresses => $listen,
                require => Class['postgresql::globals']
        }

        postgresql::server::db {'razor':
                user => $user,
                password => postgresql_password($user, $password),
#               require => Class['postgresql::server']
        }

        create_resources(postgresql::server::pg_hba_rule, $hba_rules)

}
