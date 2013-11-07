#glance

####Table of Contents

1. [Overview](#overview)
2. [Module Description](#module-description)
3. [Setup](#setup)
    * [Resources managed by glance module](#resources-managed-by-glance-module)
    * [Setup requirements](#setup-requirements)
    * [Beginning with module glance](#beginning-with-module-glance)
4. [Usage](#usage)
5. [Operating Systems Support](#operating-systems-support)
6. [Development](#development)

##Overview

This module installs, manages and configures glance.

##Module Description

The module is based on **stdmod** naming standards version 0.9.0.

Refer to http://github.com/stdmod/ for complete documentation on the common parameters.


##Setup

###Resources managed by glance module
* This module installs the glance package
* Enables the glance service
* Can manage all the configuration files (by default no file is changed)

###Setup Requirements
* PuppetLabs stdlib module
* StdMod stdmod module
* Puppet version >= 2.7.x
* Facter version >= 1.6.2

###Beginning with module glance

To install the package provided by the module just include it:

        include glance

The main class arguments can be provided either via Hiera (from Puppet 3.x) or direct parameters:

        class { 'glance':
          parameter => value,
        }

The module provides also a generic define to manage any glance configuration file:

        glance::conf { 'sample.conf':
          content => '# Test',
        }


##Usage

* A common way to use this module involves the management of the main configuration file via a custom template (provided in a custom site module):

        class { 'glance':
          config_file_template => 'site/glance/glance.conf.erb',
        }

* You can write custom templates that use setting provided but the config_file_options_hash paramenter

        class { 'glance':
          config_file_template      => 'site/glance/glance.conf.erb',
          config_file_options_hash  => {
            opt  => 'value',
            opt2 => 'value2',
          },
        }

* Use custom source (here an array) for main configuration file. Note that template and source arguments are alternative.

        class { 'glance':
          config_file_source => [ "puppet:///modules/site/glance/glance.conf-${hostname}" ,
                                  "puppet:///modules/site/glance/glance.conf" ],
        }


* Use custom source directory for the whole configuration directory, where present.

        class { 'glance':
          config_dir_source  => 'puppet:///modules/site/glance/conf/',
        }

* Use custom source directory for the whole configuration directory and purge all the local files that are not on the dir.
  Note: This option can be used to be sure that the content of a directory is exactly the same you expect, but it is desctructive and may remove files.

        class { 'glance':
          config_dir_source => 'puppet:///modules/site/glance/conf/',
          config_dir_purge  => true, # Default: false.
        }

* Use custom source directory for the whole configuration dir and define recursing policy.

        class { 'glance':
          config_dir_source    => 'puppet:///modules/site/glance/conf/',
          config_dir_recursion => false, # Default: true.
        }


##Operating Systems Support

This is tested on these OS:
- RedHat osfamily 5 and 6
- Debian 6 and 7
- Ubuntu 10.04 and 12.04


##Development

Pull requests (PR) and bug reports via GitHub are welcomed.

When submitting PR please follow these quidelines:
- Provide puppet-lint compliant code
- If possible provide rspec tests
- Follow the module style and stdmod naming standards

When submitting bug report please include or link:
- The Puppet code that triggers the error
- The output of facter on the system where you try it
- All the relevant error logs
- Any other information useful to undestand the context