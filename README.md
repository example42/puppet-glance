# Puppet module: glance

This is a Puppet module for glance based on the second generation layout ("NextGen") of Example42 Puppet Modules.

For a fully puppetized OpenStack implementation you'd better use the official StackForge modules. This module is intended to be a quick replacement for setups where you want to manage configurations based on plain files on an existing setup.

Made by Alessandro Franceschi / Lab42

Official site: http://www.example42.com

Official git repository: http://github.com/example42/puppet-glance

Released under the terms of Apache 2 License.

This module requires functions provided by the Example42 Puppi module (you need it even if you don't use and install Puppi)

For detailed info about the logic and usage patterns of Example42 modules check the DOCS directory on Example42 main modules set.


## USAGE - Basic management

* Install glance with default settings

        class { 'glance': }

* Install a specific version of glance package

        class { 'glance':
          version => '1.0.1',
        }

* Disable glance service.

        class { 'glance':
          disable => true
        }

* Remove glance package

        class { 'glance':
          absent => true
        }

* Enable auditing without without making changes on existing glance configuration *files*

        class { 'glance':
          audit_only => true
        }

* Module dry-run: Do not make any change on *all* the resources provided by the module

        class { 'glance':
          noops => true
        }


## USAGE - Overrides and Customizations
* Use custom sources for main config file 

        class { 'glance':
          source => [ "puppet:///modules/example42/glance/glance.conf-${hostname}" , "puppet:///modules/example42/glance/glance.conf" ], 
        }


* Use custom source directory for the whole configuration dir

        class { 'glance':
          source_dir       => 'puppet:///modules/example42/glance/conf/',
          source_dir_purge => false, # Set to true to purge any existing file not present in $source_dir
        }

* Use custom template for main config file. Note that template and source arguments are alternative. 

        class { 'glance':
          template => 'example42/glance/glance.conf.erb',
        }

* Automatically include a custom subclass

        class { 'glance':
          my_class => 'example42::my_glance',
        }


## USAGE - Example42 extensions management 
* Activate puppi (recommended, but disabled by default)

        class { 'glance':
          puppi    => true,
        }

* Activate puppi and use a custom puppi_helper template (to be provided separately with a puppi::helper define ) to customize the output of puppi commands 

        class { 'glance':
          puppi        => true,
          puppi_helper => 'myhelper', 
        }

* Activate automatic monitoring (recommended, but disabled by default). This option requires the usage of Example42 monitor and relevant monitor tools modules

        class { 'glance':
          monitor      => true,
          monitor_tool => [ 'nagios' , 'monit' , 'munin' ],
        }

* Activate automatic firewalling. This option requires the usage of Example42 firewall and relevant firewall tools modules

        class { 'glance':       
          firewall      => true,
          firewall_tool => 'iptables',
          firewall_src  => '10.42.0.0/24',
          firewall_dst  => $ipaddress_eth0,
        }


## CONTINUOUS TESTING

Travis {<img src="https://travis-ci.org/example42/puppet-glance.png?branch=master" alt="Build Status" />}[https://travis-ci.org/example42/puppet-glance]
