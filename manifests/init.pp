#
# = Class: glance
#
# This class installs and manages glance
#
#
# == Parameters
#
# Refer to https://github.com/stdmod for official documentation
# on the stdmod parameters used
#
class glance (

  $extra_package_name        = $glance::params::extra_package_name,

  $package_name              = $glance::params::package_name,
  $package_ensure            = 'present',

  $service_name              = $glance::params::service_name,
  $service_ensure            = 'running',
  $service_enable            = true,

  $registry_service_name     = $glance::params::registry_service_name,

  $config_file_path          = $glance::params::config_file_path,
  $config_file_replace       = $glance::params::config_file_replace,
  $config_file_require       = 'Package[glance]',
  $config_file_notify        = 'Service[glance]',
  $config_file_source        = undef,
  $config_file_template      = undef,
  $config_file_content       = undef,
  $config_file_options_hash  = undef,


  $config_dir_path           = $glance::params::config_dir_path,
  $config_dir_source         = undef,
  $config_dir_purge          = false,
  $config_dir_recurse        = true,

  $dependency_class          = undef,
  $my_class                  = undef,

  $monitor_class             = undef,
  $monitor_options_hash      = { } ,

  $firewall_class            = undef,
  $firewall_options_hash     = { } ,

  $scope_hash_filter         = '(uptime.*|timestamp)',

  $tcp_port                  = undef,
  $udp_port                  = undef,

  ) inherits glance::params {


  # Class variables validation and management

  validate_bool($service_enable)
  validate_bool($config_dir_recurse)
  validate_bool($config_dir_purge)
  if $config_file_options_hash { validate_hash($config_file_options_hash) }
  if $monitor_options_hash { validate_hash($monitor_options_hash) }
  if $firewall_options_hash { validate_hash($firewall_options_hash) }

  $config_file_owner          = $glance::params::config_file_owner
  $config_file_group          = $glance::params::config_file_group
  $config_file_mode           = $glance::params::config_file_mode

  $manage_config_file_content = default_content($config_file_content, $config_file_template)

  $manage_config_file_notify = pickx($config_file_notify)

  if $package_ensure == 'absent' {
    $manage_service_enable = undef
    $manage_service_ensure = stopped
    $config_dir_ensure = absent
    $config_file_ensure = absent
  } else {
    $manage_service_enable = $service_enable
    $manage_service_ensure = $service_ensure
    $config_dir_ensure = directory
    $config_file_ensure = present
  }


  # Resources managed

  if $glance::package_name {
    package { $glance::package_name:
      ensure   => $glance::package_ensure,
    }
  }

  if $glance::extra_package_name {
    package { $glance::extra_package_name:
      ensure   => $glance::package_ensure,
    }
  }

  if $glance::service_name {
    service { $glance::service_name:
      ensure     => $glance::manage_service_ensure,
      enable     => $glance::manage_service_enable,
    }
    service { $glance::registry_service_name:
      ensure     => $glance::manage_service_ensure,
      enable     => $glance::manage_service_enable,
    }
  }

  if $glance::config_file_path {
    file { 'glance.conf':
      ensure  => $glance::config_file_ensure,
      path    => $glance::config_file_path,
      mode    => $glance::config_file_mode,
      owner   => $glance::config_file_owner,
      group   => $glance::config_file_group,
      source  => $glance::config_file_source,
      content => $glance::manage_config_file_content,
      notify  => $glance::manage_config_file_notify,
      require => $glance::config_file_require,
    }
  }

  if $glance::config_dir_source {
    file { 'glance.dir':
      ensure  => $glance::config_dir_ensure,
      path    => $glance::config_dir_path,
      source  => $glance::config_dir_source,
      recurse => $glance::config_dir_recurse,
      purge   => $glance::config_dir_purge,
      force   => $glance::config_dir_purge,
      notify  => $glance::config_file_notify,
      require => $glance::config_file_require,
    }
  }


  # Extra classes

  if $glance::dependency_class {
    include $glance::dependency_class
  }

  if $glance::my_class {
    include $glance::my_class
  }

  if $glance::monitor_class {
    class { $glance::monitor_class:
      options_hash => $glance::monitor_options_hash,
      scope_hash   => {}, # TODO: Find a good way to inject class' scope
    }
  }

  if $glance::firewall_class {
    class { $glance::firewall_class:
      options_hash => $glance::firewall_options_hash,
      scope_hash   => {},
    }
  }

}

