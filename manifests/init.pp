# = Class: phpmyadmin
#
# This is the main phpmyadmin class
#
#
# == Parameters
#
# WebApp Specific params
#
# [*install*]
#   Kind of installation to attempt:
#     - package : Installs phpmyadmin using the OS common packages
#     - source  : Installs phpmyadmin downloading and extracting a specific
#                 tarball or zip file
#     - puppi   : Installs phpmyadmin tarball or file via Puppi, creating the
#                 "puppi deploy phpmyadmin" command
#   Can be defined also by the variable $phpmyadmin_install
#
# [*install_source*]
#   The URL from where to retrieve the source tarball/zip.
#   Used and mandatory if install => "source" or "puppi"
#   Can be defined also by the variable $phpmyadmin_install_source
#
# [*install_destination*]
#   The base path where to extract the source tarball/zip.
#   Used if install => "source" or "puppi"
#   By default is the distro's default DocumentRoot for Web server
#   Can be defined also by the variable $phpmyadmin_install_destination
#
# [*install_dirname*]
#   Name of the directory created by the source tarball/zip
#   Default is based on the official sources. You hardly need to override it
#
# [*install_precommand*]
#   A custom command to execute before installing the source tarball/zip.
#   Used if install => "source" or "puppi"
#   Check phpmyadmin/manifests/params.pp before overriding the default settings
#   Can be defined also by the variable $phpmyadmin_install_precommand
#
# [*install_postcommand*]
#   A custom command to execute after installing the source tarball/zip.
#   Used if install => "source" or "puppi"
#   Check phpmyadmin/manifests/params.pp before overriding the default settings
#   Can be defined also by the variable $phpmyadmin_install_postcommand
#
# [*url_check*]
#   An url, relevant to the phpmyadmin application, to use for testing the
#   correct deployment of phpmyadmin. Used is monitor is enabled.
#   Can be defined also by the variable $phpmyadmin_url_check
#
# [*url_pattern*]
#   A string or regexp that must exist in the defined url_check that confirms
#   that the application is running correctly
#   Can be defined also by the variable $phpmyadmin_url_pattern
#
# [*web_server*]
#   The type of web server you want to preconfigure.
#   Can be defined also by the variable $phpmyadmin_web_server
#
# [*web_server_template*]
#   The path of the template to use for web server configuration
#   Can be defined also by the variable $phpmyadmin_web_server_template
#
# [*web_virtualhost*]
#   An optional virtualhost name to map to the phpmyadmin application
#   Can be defined also by the variable $phpmyadmin_web_virtualhost
#
# [*web_virtualhost_aliases*]
#   An optional virtualhost aliases list.
#   Can be defined also by the variable $phpmyadmin_web_virtualhost_aliases
#
# [*db_name*]
#   Name of the database to create
#   Can be defined also by the variable $phpmyadmin_db_name
#
# [*db_host*]
#   Your database server hostname. Default: localhost
#   If you define an external db server and want to configure it
#   automatically, you need to have StoredConfigs activated.
#   Can be defined also by the variable $phpmyadmin_db_host
#
# [*db_user*]
#   The user phpmyadmin uses to connect to the database
#   Can be defined also by the variable $phpmyadmin_db_user
#
# [*db_password*]
#   The password used by db_user. Default is a random value
#   Can be defined also by the variable $phpmyadmin_db_password
#
# Standard class parameters
# Define the general class behaviour and customizations
#
# [*my_class*]
#   Name of a custom class to autoload to manage module's customizations
#   If defined, phpmyadmin class will automatically "include $my_class"
#   Can be defined also by the variable $phpmyadmin_myclass
#
# [*source*]
#   Sets the content of source parameter for main configuration file
#   If defined, phpmyadmin main config file will have the param:
#   source => $source
#   Can be defined also by the variable $phpmyadmin_source
#
# [*source_dir*]
#   If defined, the whole phpmyadmin configuration directory content is
#   retrieved recursively from the specified source
#   (source => $source_dir , recurse => true)
#   Can be defined also by the variable $phpmyadmin_source_dir
#
# [*source_dir_purge*]
#   If set to true (default false) the existing configuration directory is
#   mirrored with the content retrieved from source_dir
#   (source => $source_dir , recurse => true , purge => true)
#   Can be defined also by the variable $phpmyadmin_source_dir_purge
#
# [*template*]
#   Sets the path to the template to use as content for main configuration file
#   If defined, phpmyadmin main config file has: content => content("$template")
#   Note source and template parameters are mutually exclusive: don't use both
#   Can be defined also by the variable $phpmyadmin_template
#
# [*options*]
#   A hash of custom options to be used in templates for arbitrary settings.
#   Can be defined also by the variable $phpmyadmin_options
#
# [*absent*]
#   Set to 'true' to remove package(s) installed by module
#   Can be defined also by the variable $phpmyadmin_absent
#
# [*monitor*]
#   Set to 'true' to enable monitoring of the services provided by the module
#   Can be defined also by the variables $phpmyadmin_monitor
#   and $monitor
#
# [*monitor_tool*]
#   Define which monitor tools (ad defined in Example42 monitor module)
#   you want to use for phpmyadmin checks
#   Can be defined also by the variables $phpmyadmin_monitor_tool
#   and $monitor_tool
#
# [*monitor_target*]
#   The Ip address or hostname to use as a target for monitoring tools.
#   Default is the fact $ipaddress
#   Can be defined also by the variables $phpmyadmin_monitor_target
#   and $monitor_target
#
# [*puppi*]
#   Set to 'true' to enable creation of module data files that are used by puppi
#   Can be defined also by the variables $phpmyadmin_puppi and $puppi
#
# [*puppi_helper*]
#   Specify the helper to use for puppi commands. The default for this module
#   is specified in params.pp and is generally a good choice.
#   You can customize the output of puppi commands for this module using another
#   puppi helper. Use the define puppi::helper to create a new custom helper
#   Can be defined also by the variables $phpmyadmin_puppi_helper
#   and $puppi_helper
#
# [*debug*]
#   Set to 'true' to enable modules debugging
#   Can be defined also by the variables $phpmyadmin_debug and $debug
#
# [*audit_only*]
#   Set to 'true' if you don't intend to override existing configuration files
#   and want to audit the difference between existing files and the ones
#   managed by Puppet.
#   Can be defined also by the variables $phpmyadmin_audit_only
#   and $audit_only
#
# Default class params - As defined in phpmyadmin::params.
# Note that these variables are mostly defined and used in the module itself,
# overriding the default values might not affected all the involved components.
# Set and override them only if you know what you're doing.
# Note also that you can't override/set them via top scope variables.
#
# [*package*]
#   The name of phpmyadmin package
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
# [*data_dir*]
#   Path of application files
#
# [*ip_addr*]
#   The ip to configure the host on. Default: * (all IPs)
#
# [*port*]
#   The listen port. Default 80
#
# [*log_dir*]
#   Base logs directory. Used by puppi
#
# [*log_file*]
#   Log file(s). Used by puppi
#
# == Examples
#
# You can use this class in 2 ways:
# - Set variables (at top scope level on in a ENC) and "include phpmyadmin"
# - Call phpmyadmin as a parametrized class
#
# See README for details.
#
#
# == Author
#   Alessandro Franceschi <al@lab42.it/>
#
class phpmyadmin (
  $install                 = params_lookup( 'install' ),
  $install_source          = params_lookup( 'install_source' ),
  $install_destination     = params_lookup( 'install_destination' ),
  $install_dirname         = params_lookup( 'install_dirname' ),
  $install_precommand      = params_lookup( 'install_precommand' ),
  $install_postcommand     = params_lookup( 'install_postcommand' ),
  $url_check               = params_lookup( 'url_check' ),
  $url_pattern             = params_lookup( 'url_pattern' ),
  $web_server              = params_lookup( 'web_server' ),
  $web_server_template     = params_lookup( 'web_server_template' ),
  $web_virtualhost         = params_lookup( 'web_virtualhost' ),
  $web_virtualhost_aliases = params_lookup( 'web_virtualhost_aliases' ),
  $db_name                 = params_lookup( 'db_name' ),
  $db_host                 = params_lookup( 'db_host' ),
  $db_user                 = params_lookup( 'db_user' ),
  $db_password             = params_lookup( 'db_password' ),
  $my_class                = params_lookup( 'my_class' ),
  $source                  = params_lookup( 'source' ),
  $source_dir              = params_lookup( 'source_dir' ),
  $source_dir_purge        = params_lookup( 'source_dir_purge' ),
  $template                = params_lookup( 'template' ),
  $options                 = params_lookup( 'options' ),
  $absent                  = params_lookup( 'absent' ),
  $monitor                 = params_lookup( 'monitor' , 'global' ),
  $monitor_tool            = params_lookup( 'monitor_tool' , 'global' ),
  $monitor_target          = params_lookup( 'monitor_target' , 'global' ),
  $puppi                   = params_lookup( 'puppi' , 'global' ),
  $puppi_helper            = params_lookup( 'puppi_helper' , 'global' ),
  $debug                   = params_lookup( 'debug' , 'global' ),
  $audit_only              = params_lookup( 'audit_only' , 'global' ),
  $package                 = params_lookup( 'package' ),
  $config_dir              = params_lookup( 'config_dir' ),
  $config_file             = params_lookup( 'config_file' ),
  $config_file_mode        = params_lookup( 'config_file_mode' ),
  $config_file_owner       = params_lookup( 'config_file_owner' ),
  $config_file_group       = params_lookup( 'config_file_group' ),
  $data_dir                = params_lookup( 'data_dir' ),
  $ip_addr                 = params_lookup( 'ip_addr' ),
  $port                    = params_lookup( 'port' ),
  $log_dir                 = params_lookup( 'log_dir' ),
  $log_file                = params_lookup( 'log_file' ),
  $mysql_servers           = params_lookup( 'mysql_servers' ),
  ) inherits phpmyadmin::params {

  $bool_source_dir_purge=any2bool($source_dir_purge)
  $bool_absent=any2bool($absent)
  $bool_monitor=any2bool($monitor)
  $bool_puppi=any2bool($puppi)
  $bool_debug=any2bool($debug)
  $bool_audit_only=any2bool($audit_only)

  if $install != 'package' and $install_source == '' {
    fail("'*install_source*' must be set when '*install*' is set to ${install}")
  }

  ### Definition of some variables used in the module
  $manage_package = $phpmyadmin::bool_absent ? {
    true  => 'absent',
    false => 'present',
  }

  $manage_file = $phpmyadmin::bool_absent ? {
    true    => 'absent',
    default => 'present',
  }

  if $phpmyadmin::bool_absent == true {
    $manage_monitor = false
  } else {
    $manage_monitor = true
  }

  $manage_audit = $phpmyadmin::bool_audit_only ? {
    true  => 'all',
    false => undef,
  }

  $manage_file_replace = $phpmyadmin::bool_audit_only ? {
    true  => false,
    false => true,
  }

  $manage_file_source = $phpmyadmin::source ? {
    ''        => undef,
    default   => $phpmyadmin::source,
  }

  $manage_file_content = $phpmyadmin::template ? {
    ''      => undef,
    default => $phpmyadmin::source ? {
      ''      => template($phpmyadmin::template),
      default => undef,
    }
  }

  $manage_install_dirname = $phpmyadmin::install_dirname ? {
    ''      => $phpmyadmin::install ? {
      'package' => '',
      default   => regsubst(
        url_parse(
          $phpmyadmin::install_source,
          'filedir')
        ,'.tar'
      ,'')
    },
    default => $phpmyadmin::install_dirname,
  }

  ### Calculations of variables whoe value depends on different params
  $real_install_destination = $phpmyadmin::install_destination ? {
    ''      => $phpmyadmin::web_server ? {
      default => $::operatingsystem ? {
        /(?i:Debian|Ubuntu|Mint)/ => '/var/www',
        /(?i:Suse|OpenSuse)/      => '/srv/www',
        default                   => '/var/www/html',
      },
    },
    default => $phpmyadmin::install_destination,
  }

  $real_config_file = $phpmyadmin::config_file ? {
    ''      => $phpmyadmin::install ? {
      package => $::operatingsystem ? {
        default => '/etc/phpmyadmin/config.inc.php',
      },
      default => "${phpmyadmin::real_install_destination}/${phpmyadmin::manage_install_dirname}/config.inc.php",
    },
    default => $phpmyadmin::config_file,
  }

  $real_config_dir = $phpmyadmin::config_dir ? {
    ''      => $phpmyadmin::install ? {
      package => $::operatingsystem ? {
        default => '/etc/phpmyadmin/',
      },
      default => "${phpmyadmin::real_install_destination}/${phpmyadmin::manage_install_dirname}/",
    },
    default => $phpmyadmin::config_dir,
  }

  $real_data_dir = $phpmyadmin::data_dir ? {
    ''      => $phpmyadmin::install ? {
      default => "${phpmyadmin::real_install_destination}/${phpmyadmin::manage_install_dirname}",
    },
    default => $phpmyadmin::data_dir,
  }

  $real_web_server_template = $phpmyadmin::web_server_template ? {
    ''      => $phpmyadmin::web_server ? {
      apache  =>  'phpmyadmin/apache/virtualhost.conf.erb',
      nginx   =>  'phpmyadmin/nginx/virtualhost.conf.erb',
    },
    default => $phpmyadmin::web_server_template,
  }

  $real_data_dir_user = $phpmyadmin::web_server ? {
    default => $::operatingsystem ? {
      /(?i:Ubuntu|Debian|Mint)/ => 'www-data',
      default                   => 'apache',
    }
  }

  # This sets the right permissions for config.inc.php
  $real_install_postcommand = $install_postcommand

  ### Managed resources
  # Installation is managed in dedicated class
  require phpmyadmin::install

  file { 'phpmyadmin.conf':
    ensure  => $phpmyadmin::manage_file,
    path    => $phpmyadmin::real_config_file,
    mode    => $phpmyadmin::config_file_mode,
    owner   => $phpmyadmin::config_file_owner,
    group   => $phpmyadmin::config_file_group,
    require => Class['phpmyadmin::install'],
    source  => $phpmyadmin::manage_file_source,
    content => $phpmyadmin::manage_file_content,
    replace => $phpmyadmin::manage_file_replace,
    audit   => $phpmyadmin::manage_audit,
  }

  # The whole phpmyadmin configuration directory can be recursively overriden
  if $phpmyadmin::source_dir {
    file { 'phpmyadmin.dir':
      ensure  => directory,
      path    => $phpmyadmin::real_config_dir,
      require => Class['phpmyadmin::install'],
      source  => $source_dir,
      recurse => true,
      purge   => $source_dir_purge,
      replace => $phpmyadmin::manage_file_replace,
      audit   => $phpmyadmin::manage_audit,
    }
  }


  ### Include custom class if $my_class is set
  if $phpmyadmin::my_class {
    include $phpmyadmin::my_class
  }

  # Include web server configuration if requested
  case $phpmyadmin::web_server {
    apache: {
      apache::vhost { 'phpmyadmin' :
        server_name   => $phpmyadmin::web_virtualhost,
        serveraliases => $phpmyadmin::web_virtualhost_aliases,
        template      => $phpmyadmin::real_web_server_template,
        docroot       => $phpmyadmin::real_data_dir,
        port          => $phpmyadmin::port,
        ip_addr       => $phpmyadmin::ip_addr,
      }
    }
    nginx: { include phpmyadmin::nginx }
    default: { }
  }

  ### Provide puppi data, if enabled ( puppi => true )
  if $phpmyadmin::bool_puppi == true {
    $classvars=get_class_args()
    puppi::ze { 'phpmyadmin':
      ensure    => $phpmyadmin::manage_file,
      variables => $classvars,
      helper    => $phpmyadmin::puppi_helper,
    }
  }


  ### Service monitoring, if enabled ( monitor => true )
  if $phpmyadmin::bool_monitor == true and $phpmyadmin::url_check != '' {
    monitor::url { 'phpmyadmin_url':
      url     => $phpmyadmin::url_check,
      pattern => $phpmyadmin::url_pattern,
      port    => $phpmyadmin::port,
      target  => $phpmyadmin::params::monitor_target,
      tool    => $phpmyadmin::monitor_tool,
      enable  => $phpmyadmin::manage_monitor,
    }
  }


  ### Debugging, if enabled ( debug => true )
  if $phpmyadmin::bool_debug == true {
    file { 'debug_phpmyadmin':
      ensure  => $phpmyadmin::manage_file,
      path    => "${settings::vardir}/debug-phpmyadmin",
      mode    => '0640',
      owner   => 'root',
      group   => 'root',
      content => inline_template('<%= scope.to_hash.reject { |k,v| k.to_s =~ /(uptime.*|path|timestamp|free|.*password.*|.*psk.*|.*key)/ }.to_yaml %>'),
    }
  }
}
