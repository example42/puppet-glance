# Class: glance::params
#
# Defines all the variables used in the module.
#
class glance::params {

  $package_name = $::osfamily ? {
    'RedHat' => 'openstack-glance',
    default  => 'glance',
  }

  $service_name = $::osfamily ? {
     default  => '',
  }

  $config_file_path = $::osfamily ? {
    default => '/etc/glance/glance.conf',
  }

  $config_file_mode = $::osfamily ? {
    default => '0640',
  }

  $config_file_owner = $::osfamily ? {
    default => 'root',
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
