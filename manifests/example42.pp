# = Class: glance::example42
#
# Example42 puppi additions. To add them set:
#   my_class => 'glance::example42'
#
class glance::example42 {

  puppi::info::module { 'glance':
    packagename => $glance::package_name,
    servicename => $glance::service_name,
    processname => 'glance',
    configfile  => $glance::config_file_path,
    configdir   => $glance::config_dir_path,
    pidfile     => '/var/run/glance.pid',
    datadir     => '',
    logdir      => '/var/log/glance',
    protocol    => 'tcp',
    port        => '5000',
    description => 'What Puppet knows about glance' ,
    # run         => 'glance -V###',
  }

  puppi::log { 'glance':
    description => 'Logs of glance',
    log         => [ '/var/log/glance/api.log' , '/var/log/glance/registry.log' ],
  }

}
