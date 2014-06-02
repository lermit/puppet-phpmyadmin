# Puppet module: phpmyadmin

This is a Puppet phpmyadmin module from the second generation of Example42 Puppet Modules.

Made by Alessandro Franceschi / Lab42

Official site: http://www.example42.com

Official git repository: http://github.com/example42/puppet-phpmyadmin

Released under the terms of Apache 2 License.

This module requires functions provided by the Example42 Puppi module.

For detailed info about the logic and usage patterns of Example42 modules read README.usage on Example42 main modules set.

## USAGE - Basic management

* Install phpmyadmin using your distro package, if available

        class { "phpmyadmin": }

* Install the latest phpmyadmin version from upstream site

        class { "phpmyadmin":
          install             => "source",
        }

* Install the latest phpmyadmin version from upstream site using puppi. 
  You will have a 'puppi deploy phpmyadmin' to deploy and update phpmyadmin.

        class { "phpmyadmin":
          install             => "puppi",
        }

* Install source from a custom url to a custom install_destination path.
  The following parameters apply both for "source" and "puppi" install methods.
  Puppi method may be used to manage deployment updates (given the $install_source is updated).
  By default install_source is set to upstream developer and install_destination to Web (App) server document root
  Pre and post installation commands may be already defined (check phpmyadmin/manifests/params.pp) override them only if needed.
  Url_check and url_pattern are used for application checks, if monitor is enabled. Override only if needed.

        class { "phpmyadmin":
          install             => "source",
          install_source      => "http://deploy.example42.com/phpmyadmin/phpmyadmin.tar.gz",
        }

* Remove phpmyadmin

        class { "phpmyadmin":
          absent => true
        }

* Enable auditing without without making changes on existing phpmyadmin configuration files

        class { "phpmyadmin":
          audit_only => true
        }


## USAGE - Overrides and Customizations
* Use custom sources for main config file 

        class { "phpmyadmin":
          source => [ "puppet:///modules/lab42/phpmyadmin/wp-config.php-${hostname}" , "puppet:///modules/lab42/phpmyadmin/wp-config.php" ], 
        }


* Use custom source directory for the whole configuration dir

        class { "phpmyadmin":
          source_dir       => "puppet:///modules/lab42/phpmyadmin/conf/",
          source_dir_purge => false, # Set to true to purge any existing file not present in $source_dir
        }

* Use custom template for main config file 

        class { "phpmyadmin":
          template => "example42/phpmyadmin/wp-config.php.erb",      
        }

* Automaticallly include a custom subclass

        class { "phpmyadmin":
          my_class => 'phpmyadmin::example42',
        }

* Use custom options with existing template. Full list includes: DB_CHARSET, DB_COLLATE, AUTH_KEY, SECURE_AUTH_KEY, LOGGED_IN_KEY, NONCE_KEY, AUTH_SALT, SECURE_AUTH_SALT, LOGGED_IN_SALT, NONCE_SALT, table_prefix, WPLANG, WP_DEBUG

        class { "phpmyadmin":
          options => {
            'DB_CHARSET' => 'utf8',
            'DB_COLLATE' => 'utf8_general_ci',
            'WP_DEBUG'   => 'true',
          },
        }


## USAGE - Example42 extensions management 
* Activate puppi (recommended, but disabled by default)
  Note that this option requires the usage of Example42 puppi module

        class { "phpmyadmin": 
          puppi    => true,
        }

* Activate puppi and use a custom puppi_helper template (to be provided separately with
  a puppi::helper define ) to customize the output of puppi commands 

        class { "phpmyadmin":
          puppi        => true,
          puppi_helper => "myhelper", 
        }

* Activate automatic monitoring (recommended, but disabled by default)
  This option requires the usage of Example42 monitor and relevant monitor tools modules

        class { "phpmyadmin":
          monitor      => true,
          monitor_tool => [ "nagios" , "puppi" ],
        }


[![Build Status](https://travis-ci.org/example42/puppet-phpmyadmin.png?branch=master)](https://travis-ci.org/example42/puppet-phpmyadmin)
