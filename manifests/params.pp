# Class: glance::params
#
# Defines all the variables used in the module.
#
class glance::params {

  $extra_package_name = $::osfamily ? {
    default  => 'python-glance',
  }

  $package_name = $::osfamily ? {
    'Redhat' => 'openstack-glance',
    default  => 'glance',
  }

  $service_name = $::osfamily ? {
    'Redhat' => 'openstack-glance-api',
    default  => 'glance-api',
  }

  $registry_service_name = $::osfamily ? {
    'Redhat' => 'openstack-glance-registry',
    default  => 'glance-registry',
  }

  $config_file_path = $::osfamily ? {
    default => '/etc/glance/glance-api.conf',
  }

  $config_file_mode = $::osfamily ? {
    default => '0644',
  }

  $config_file_owner = $::osfamily ? {
    default => 'glance',
  }

  $config_file_group = $::osfamily ? {
    default => 'glance',
  }

  $config_dir_path = $::osfamily ? {
    default => '/etc/glance',
  }

  case $::osfamily {
    'Debian','RedHat','Amazon': { }
    default: {
      fail("${::operatingsystem} not supported. Review params.pp for extending support.")
    }
  }
}
