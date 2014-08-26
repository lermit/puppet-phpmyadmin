# Class: phpmyadmin::params
#
# This class defines default parameters used by the main module class phpmyadmin
# Operating Systems differences in names and paths are addressed here
#
# == Variables
#
# Refer to phpmyadmin class for the variables defined here.
#
# == Usage
#
# This class is not intended to be used directly.
# It may be imported or inherited by other classes
#
class phpmyadmin::params {

  ### WebApp specific parameters
  $install = 'package'
  $install_source = ''
  $install_dirname = ''
  $install_precommand = ''
  $install_postcommand = ''
  $url_check = ''
  $url_pattern = 'phpmyadmin'
  $web_server = 'apache'
  $web_server_template = ''
  $web_virtualhost = "phpmyadmin.${::fqdn}"
  $web_virtualhost_aliases = ''
  $db_host = 'localhost'
  $db_name = 'phpmyadmin'
  $db_user = 'phpmyadmin'
  $db_password = fqdn_rand(100000000000)

  $mysql_servers = [ 'localhost' ]

  ### Application related parameters

  $package = $::operatingsystem ? {
    default => 'phpmyadmin',
  }

  $config_file_mode = $::operatingsystem ? {
    default => '0644',
  }

  $config_file_owner = $::operatingsystem ? {
    default => 'root',
  }

  $config_file_group = $::operatingsystem ? {
    default => 'root',
  }

  $log_dir = $::operatingsystem ? {
    default => '',
  }

  $log_file = $::operatingsystem ? {
    default => '',
  }

  # General Settings
  $my_class = ''
  $source = ''
  $source_dir = ''
  $source_dir_purge = ''
  $template = 'phpmyadmin/config.inc.php.erb'
  $options = { }
  $absent = false
  $ip_addr = '*'
  $port = 80

  ### General module variables that can have a site or per module default
  $monitor = false
  $monitor_tool = ''
  $monitor_target = $::ipaddress
  $puppi = false
  $puppi_helper = 'phpapp'
  $debug = false
  $audit_only = false

}
