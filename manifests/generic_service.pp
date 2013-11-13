#
# This class implements basic generic services.
# It is derived from https://github.com/stackforge/puppet-glance/blob/master/manifests/generic_service.pp
#
# It also allows users to specify ad-hoc services as needed
#
# This define creates a service resource with title glance-${name} and
# conditionally creates a package resource with title glance-${name}
#
define glance::generic_service (
  $package_name   = '',
  $package_ensure = 'present'
  $service_name   = '',
  $service_ensure = 'running',
  $service_enable = true,
) {

  $distro_prefix = $::osfamily ? {
    RedHat => 'openstack-glance-',
    Debian => 'glance-',
  }

  $manage_package_name = pickx($package_name, "${distro_prefix}${name}")
  $manage_service_name = pickx($service_name, "${distro_prefix}${name}")

  Package<| title == $manage_package_name |> -> Glance::Conf<| |> -> Service<| title == $manage_service_name |>

  if ($manage_package_name) {
    package { $manage_package_name:
      ensure => $package_ensure,
    }
  }

  if ($manage_service_name) {
    service { $manage_service_name:
      ensure    => $service_ensure,
      enable    => $service_enable,
      require   => Package[$manage_package_name],
    }
  }

}
