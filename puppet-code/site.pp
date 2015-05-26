node default {

        $role = hiera('role')

        class{"roles::${role}": }
}
