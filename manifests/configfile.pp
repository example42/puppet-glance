#
# = Define: glance::configfile
#
# The define manages glance configfile
#
#
# == Parameters
#
# [*ensure*]
#   String. Default: present
#   Manages configfile presence. Possible values:
#   * 'present' - Install package, ensure files are present.
#   * 'absent' - Stop service and remove package and managed files
#
# [*template*]
#   String. Default: Provided by the module.
#   Sets the path of a custom template to use as content of configfile
#   If defined, configfile file has: content => content("$template")
#   Example: template => 'site/configfile.conf.erb',
#
# [*options*]
#   Hash. Default undef. Needs: 'template'.
#   An hash of custom options to be used in templates to manage any key pairs of
#   arbitrary settings.
#
define glance::configfile (
  $template ,
  $ensure   = present,
  $options  = '' ,
  $ensure  = present ) {

  include glance

  file { "glance_configfile_${name}":
    ensure  => $ensure,
    path    => "${glance::config_dir}/${name}",
    mode    => $glance::config_file_mode,
    owner   => $glance::config_file_owner,
    group   => $glance::config_file_group,
    require => Package[$glance::package],
    notify  => $glance::manage_registry_service_autorestart,
    content => template($template),
    replace => $glance::manage_file_replace,
    audit   => $glance::manage_audit,
    noop    => $glance::bool_noops,
  }

}
