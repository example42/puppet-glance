class glance::puppi {

  # For Puppi 2 (WIP)
  $classvars=get_class_args()
  puppi::ze { 'glance':
    ensure    => $glance::manage_file,
    variables => $classvars,
    helper    => $glance::puppi_helper,
    noop      => $glance::bool_noops,
  }

  # For Puppi 1
  puppi::info::module { "glance":
    packagename => "${glance::package}",
    servicename => "${glance::service}",
    processname => "${glance::process}",
    configfile  => "${glance::config_file}",
    configdir   => "${glance::config_dir}",
    pidfile     => "${glance::pid_file}",
    datadir     => "${glance::data_dir}",
    logdir      => "${glance::log_dir}",
    protocol    => "${glance::protocol}",
    port        => "${glance::port}",
    description => "What Puppet knows about glance" ,
    # run         => "glance -V###",
  }

  puppi::log { "glance":
    description => "Logs of glance" ,  
    log      => "${glance::log_file}",
  }

}
