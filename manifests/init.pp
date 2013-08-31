# = Class: glance
#
# This is the main glance class
#
#
# == Parameters
#
# Standard class parameters
# Define the general class behaviour and customizations
#
# [*my_class*]
#   Name of a custom class to autoload to manage module's customizations
#   If defined, glance class will automatically "include $my_class"
#   Can be defined also by the (top scope) variable $glance_myclass
#
# [*source*]
#   Sets the content of source parameter for main configuration file
#   If defined, glance main config file will have the param: source => $source
#   Can be defined also by the (top scope) variable $glance_source
#
# [*source_dir*]
#   If defined, the whole glance configuration directory content is retrieved
#   recursively from the specified source
#   (source => $source_dir , recurse => true)
#   Can be defined also by the (top scope) variable $glance_source_dir
#
# [*source_dir_purge*]
#   If set to true (default false) the existing configuration directory is
#   mirrored with the content retrieved from source_dir
#   (source => $source_dir , recurse => true , purge => true)
#   Can be defined also by the (top scope) variable $glance_source_dir_purge
#
# [*template*]
#   Sets the path to the template to use as content for main configuration file
#   If defined, glance main config file has: content => content("$template")
#   Note source and template parameters are mutually exclusive: don't use both
#   Can be defined also by the (top scope) variable $glance_template
#
# [*options*]
#   An hash of custom options to be used in templates for arbitrary settings.
#   Can be defined also by the (top scope) variable $glance_options
#
# [*service_autorestart*]
#   Automatically restarts the glance service when there is a change in
#   configuration files. Default: true, Set to false if you don't want to
#   automatically restart the service.
#
# [*version*]
#   The package version, used in the ensure parameter of package type.
#   Default: present. Can be 'latest' or a specific version number.
#   Note that if the argument absent (see below) is set to true, the
#   package is removed, whatever the value of version parameter.
#
# [*absent*]
#   Set to 'true' to remove package(s) installed by module
#   Can be defined also by the (top scope) variable $glance_absent
#
# [*disable*]
#   Set to 'true' to disable service(s) managed by module
#   Can be defined also by the (top scope) variable $glance_disable
#
# [*disableboot*]
#   Set to 'true' to disable service(s) at boot, without checks if it's running
#   Use this when the service is managed by a tool like a cluster software
#   Can be defined also by the (top scope) variable $glance_disableboot
#
# [*monitor*]
#   Set to 'true' to enable monitoring of the services provided by the module
#   Can be defined also by the (top scope) variables $glance_monitor
#   and $monitor
#
# [*monitor_tool*]
#   Define which monitor tools (ad defined in Example42 monitor module)
#   you want to use for glance checks
#   Can be defined also by the (top scope) variables $glance_monitor_tool
#   and $monitor_tool
#
# [*monitor_target*]
#   The Ip address or hostname to use as a target for monitoring tools.
#   Default is the fact $ipaddress
#   Can be defined also by the (top scope) variables $glance_monitor_target
#   and $monitor_target
#
# [*puppi*]
#   Set to 'true' to enable creation of module data files that are used by puppi
#   Can be defined also by the (top scope) variables $glance_puppi and $puppi
#
# [*puppi_helper*]
#   Specify the helper to use for puppi commands. The default for this module
#   is specified in params.pp and is generally a good choice.
#   You can customize the output of puppi commands for this module using another
#   puppi helper. Use the define puppi::helper to create a new custom helper
#   Can be defined also by the (top scope) variables $glance_puppi_helper
#   and $puppi_helper
#
# [*firewall*]
#   Set to 'true' to enable firewalling of the services provided by the module
#   Can be defined also by the (top scope) variables $glance_firewall
#   and $firewall
#
# [*firewall_tool*]
#   Define which firewall tool(s) (ad defined in Example42 firewall module)
#   you want to use to open firewall for glance port(s)
#   Can be defined also by the (top scope) variables $glance_firewall_tool
#   and $firewall_tool
#
# [*firewall_src*]
#   Define which source ip/net allow for firewalling glance. Default: 0.0.0.0/0
#   Can be defined also by the (top scope) variables $glance_firewall_src
#   and $firewall_src
#
# [*firewall_dst*]
#   Define which destination ip to use for firewalling. Default: $ipaddress
#   Can be defined also by the (top scope) variables $glance_firewall_dst
#   and $firewall_dst
#
# [*debug*]
#   Set to 'true' to enable modules debugging
#   Can be defined also by the (top scope) variables $glance_debug and $debug
#
# [*audit_only*]
#   Set to 'true' if you don't intend to override existing configuration files
#   and want to audit the difference between existing files and the ones
#   managed by Puppet.
#   Can be defined also by the (top scope) variables $glance_audit_only
#   and $audit_only
#
# [*noops*]
#   Set noop metaparameter to true for all the resources managed by the module.
#   Basically you can run a dryrun for this specific module if you set
#   this to true. Default: undef
#
# Default class params - As defined in glance::params.
# Note that these variables are mostly defined and used in the module itself,
# overriding the default values might not affected all the involved components.
# Set and override them only if you know what you're doing.
# Note also that you can't override/set them via top scope variables.
#
# [*package*]
#   The name of glance package
#
# [*service*]
#   The name of glance service
#
# [*service_status*]
#   If the glance service init script supports status argument
#
# [*process*]
#   The name of glance process
#
# [*process_args*]
#   The name of glance arguments. Used by puppi and monitor.
#   Used only in case the glance process name is generic (java, ruby...)
#
# [*process_user*]
#   The name of the user glance runs with. Used by puppi and monitor.
#
# [*config_dir*]
#   Main configuration directory. Used by puppi
#
# [*config_file*]
#   Main configuration file path
#
# [*config_file_mode*]
#   Main configuration file path mode
#
# [*config_file_owner*]
#   Main configuration file path owner
#
# [*config_file_group*]
#   Main configuration file path group
#
# [*pid_file*]
#   Path of pid file. Used by monitor
#
# [*data_dir*]
#   Path of application data directory. Used by puppi
#
# [*log_dir*]
#   Base logs directory. Used by puppi
#
# [*log_file*]
#   Log file(s). Used by puppi
#
# [*port*]
#   The listening port, if any, of the service.
#   This is used by monitor, firewall and puppi (optional) components
#   Note: This doesn't necessarily affect the service configuration file
#   Can be defined also by the (top scope) variable $glance_port
#
# [*protocol*]
#   The protocol used by the the service.
#   This is used by monitor, firewall and puppi (optional) components
#   Can be defined also by the (top scope) variable $glance_protocol
#
#
# See README for usage patterns.
#
class glance (
  $registry_config_file      = params_lookup( 'registry_config_file' ),
  $registry_service_registry = params_lookup( 'registry_service' ),
  $registry_source           = params_lookup( 'registry_source' ),
  $registry_template         = params_lookup( 'registry_template' ),
  $my_class            = params_lookup( 'my_class' ),
  $source              = params_lookup( 'source' ),
  $source_registry     = params_lookup( 'source_registry' ),
  $source_dir          = params_lookup( 'source_dir' ),
  $source_dir_purge    = params_lookup( 'source_dir_purge' ),
  $template            = params_lookup( 'template' ),
  $template_registry   = params_lookup( 'template_registry' ),
  $service_autorestart = params_lookup( 'service_autorestart' , 'global' ),
  $options             = params_lookup( 'options' ),
  $version             = params_lookup( 'version' ),
  $absent              = params_lookup( 'absent' ),
  $disable             = params_lookup( 'disable' ),
  $disableboot         = params_lookup( 'disableboot' ),
  $monitor             = params_lookup( 'monitor' , 'global' ),
  $monitor_tool        = params_lookup( 'monitor_tool' , 'global' ),
  $monitor_target      = params_lookup( 'monitor_target' , 'global' ),
  $puppi               = params_lookup( 'puppi' , 'global' ),
  $puppi_helper        = params_lookup( 'puppi_helper' , 'global' ),
  $firewall            = params_lookup( 'firewall' , 'global' ),
  $firewall_tool       = params_lookup( 'firewall_tool' , 'global' ),
  $firewall_src        = params_lookup( 'firewall_src' , 'global' ),
  $firewall_dst        = params_lookup( 'firewall_dst' , 'global' ),
  $debug               = params_lookup( 'debug' , 'global' ),
  $audit_only          = params_lookup( 'audit_only' , 'global' ),
  $noops               = params_lookup( 'noops' ),
  $package             = params_lookup( 'package' ),
  $service             = params_lookup( 'service' ),
  $service_registry    = params_lookup( 'service_registry' ),
  $service_status      = params_lookup( 'service_status' ),
  $process             = params_lookup( 'process' ),
  $process_args        = params_lookup( 'process_args' ),
  $process_user        = params_lookup( 'process_user' ),
  $config_dir          = params_lookup( 'config_dir' ),
  $config_file         = params_lookup( 'config_file' ),
  $config_file_mode    = params_lookup( 'config_file_mode' ),
  $config_file_owner   = params_lookup( 'config_file_owner' ),
  $config_file_group   = params_lookup( 'config_file_group' ),
  $pid_file            = params_lookup( 'pid_file' ),
  $data_dir            = params_lookup( 'data_dir' ),
  $log_dir             = params_lookup( 'log_dir' ),
  $log_file            = params_lookup( 'log_file' ),
  $port                = params_lookup( 'port' ),
  $protocol            = params_lookup( 'protocol' )
  ) inherits glance::params {

  $bool_source_dir_purge=any2bool($source_dir_purge)
  $bool_service_autorestart=any2bool($service_autorestart)
  $bool_absent=any2bool($absent)
  $bool_disable=any2bool($disable)
  $bool_disableboot=any2bool($disableboot)
  $bool_monitor=any2bool($monitor)
  $bool_puppi=any2bool($puppi)
  $bool_firewall=any2bool($firewall)
  $bool_debug=any2bool($debug)
  $bool_audit_only=any2bool($audit_only)

  ### Definition of some variables used in the module
  $manage_package = $glance::bool_absent ? {
    true  => 'absent',
    false => $glance::version,
  }

  $manage_service_enable = $glance::bool_disableboot ? {
    true    => false,
    default => $glance::bool_disable ? {
      true    => false,
      default => $glance::bool_absent ? {
        true  => false,
        false => true,
      },
    },
  }

  $manage_service_ensure = $glance::bool_disable ? {
    true    => 'stopped',
    default =>  $glance::bool_absent ? {
      true    => 'stopped',
      default => 'running',
    },
  }

  $manage_service_autorestart = $glance::bool_service_autorestart ? {
    true    => Service[glance],
    false   => undef,
  }

  $manage_registry_service_autorestart = $glance::bool_service_autorestart ? {
    true    => Service[glance_registry],
    false   => undef,
  }

  $manage_file = $glance::bool_absent ? {
    true    => 'absent',
    default => 'present',
  }

  if $glance::bool_absent == true
  or $glance::bool_disable == true
  or $glance::bool_disableboot == true {
    $manage_monitor = false
  } else {
    $manage_monitor = true
  }

  if $glance::bool_absent == true
  or $glance::bool_disable == true {
    $manage_firewall = false
  } else {
    $manage_firewall = true
  }

  $manage_audit = $glance::bool_audit_only ? {
    true  => 'all',
    false => undef,
  }

  $manage_file_replace = $glance::bool_audit_only ? {
    true  => false,
    false => true,
  }

  $manage_file_source = $glance::source ? {
    ''        => undef,
    default   => $glance::source,
  }

  $manage_file_content = $glance::template ? {
    ''        => undef,
    default   => template($glance::template),
  }

  $manage_registry_file_source = $glance::registry_source ? {
    ''        => undef,
    default   => $glance::registry_source,
  }

  $manage_registry_file_content = $glance::registry_template ? {
    ''        => undef,
    default   => template($glance::registry_template),
  }

  ### Managed resources
  package { $glance::package:
    ensure  => $glance::manage_package,
    noop    => $glance::noops,
  }

  service { 'glance':
    ensure     => $glance::manage_service_ensure,
    name       => $glance::service,
    enable     => $glance::manage_service_enable,
    hasstatus  => $glance::service_status,
    pattern    => $glance::process,
    require    => Package[$glance::package],
    noop       => $glance::noops,
  }

  service { 'glance_registry':
    ensure     => $glance::manage_service_ensure,
    name       => $glance::registry_service,
    enable     => $glance::manage_service_enable,
    hasstatus  => $glance::service_status,
    pattern    => $glance::process,
    require    => Package[$glance::package],
    noop       => $glance::noops,
  }

  file { 'glance.conf':
    ensure  => $glance::manage_file,
    path    => $glance::config_file,
    mode    => $glance::config_file_mode,
    owner   => $glance::config_file_owner,
    group   => $glance::config_file_group,
    require => Package[$glance::package],
    notify  => $glance::manage_service_autorestart,
    source  => $glance::manage_file_source,
    content => $glance::manage_file_content,
    replace => $glance::manage_file_replace,
    audit   => $glance::manage_audit,
    noop    => $glance::noops,
  }

  file { 'glance.conf_registry':
    ensure  => $glance::manage_file,
    path    => $glance::registry_config_file,
    mode    => $glance::config_file_mode,
    owner   => $glance::config_file_owner,
    group   => $glance::config_file_group,
    require => Package[$glance::package],
    notify  => $glance::manage_registry_service_autorestart,
    source  => $glance::manage_registry_file_source,
    content => $glance::manage_registry_file_content,
    replace => $glance::manage_file_replace,
    audit   => $glance::manage_audit,
    noop    => $glance::noops,
  }
  # The whole glance configuration directory can be recursively overriden
  if $glance::source_dir {
    file { 'glance.dir':
      ensure  => directory,
      path    => $glance::config_dir,
      require => Package[$glance::package],
      notify  => $glance::manage_service_autorestart,
      source  => $glance::source_dir,
      recurse => true,
      purge   => $glance::bool_source_dir_purge,
      force   => $glance::bool_source_dir_purge,
      replace => $glance::manage_file_replace,
      audit   => $glance::manage_audit,
      noop    => $glance::noops,
    }
  }


  ### Include custom class if $my_class is set
  if $glance::my_class {
    include $glance::my_class
  }


  ### Provide puppi data, if enabled ( puppi => true )
  if $glance::bool_puppi == true {
    include glance::puppi 
  }


  ### Service monitoring, if enabled ( monitor => true )
  if $glance::bool_monitor == true {
    if $glance::port != '' {
      monitor::port { "glance_${glance::protocol}_${glance::port}":
        protocol => $glance::protocol,
        port     => $glance::port,
        target   => $glance::monitor_target,
        tool     => $glance::monitor_tool,
        enable   => $glance::manage_monitor,
        noop     => $glance::noops,
      }
    }
    if $glance::service != '' {
      monitor::process { 'glance_process':
        process  => $glance::process,
        service  => $glance::service,
        pidfile  => $glance::pid_file,
        user     => $glance::process_user,
        argument => $glance::process_args,
        tool     => $glance::monitor_tool,
        enable   => $glance::manage_monitor,
        noop     => $glance::noops,
      }
    }
  }


  ### Firewall management, if enabled ( firewall => true )
  if $glance::bool_firewall == true and $glance::port != '' {
    firewall { "glance_${glance::protocol}_${glance::port}":
      source      => $glance::firewall_src,
      destination => $glance::firewall_dst,
      protocol    => $glance::protocol,
      port        => $glance::port,
      action      => 'allow',
      direction   => 'input',
      tool        => $glance::firewall_tool,
      enable      => $glance::manage_firewall,
      noop        => $glance::noops,
    }
  }


  ### Debugging, if enabled ( debug => true )
  if $glance::bool_debug == true {
    file { 'debug_glance':
      ensure  => $glance::manage_file,
      path    => "${settings::vardir}/debug-glance",
      mode    => '0640',
      owner   => 'root',
      group   => 'root',
      content => inline_template('<%= scope.to_hash.reject { |k,v| k.to_s =~ /(uptime.*|path|timestamp|free|.*password.*|.*psk.*|.*key)/ }.to_yaml %>'),
      noop    => $glance::noops,
    }
  }

}
