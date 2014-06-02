# Class: phpmyadmin::install
#
# This class installs phpmyadmin
#
# == Variables
#
# Refer to phpmyadmin class for the variables defined here.
#
# == Usage
#
# This class is not intended to be used directly.
# It's automatically included by phpmyadmin
#
class phpmyadmin::install inherits phpmyadmin {

  case $phpmyadmin::install {

    package: {
      package { 'phpmyadmin':
        ensure => $phpmyadmin::manage_package,
        name   => $phpmyadmin::package,
      }
    }

    source: {
      puppi::netinstall { 'netinstall_phpmyadmin':
        url                 => $phpmyadmin::install_source,
        destination_dir     => $phpmyadmin::real_install_destination,
        extracted_dir       => $phpmyadmin::install_dirname,
        preextract_command  => $phpmyadmin::install_precommand,
        postextract_command => $phpmyadmin::real_install_postcommand,
      }
    }

    puppi: {
      puppi::project::archive { 'phpmyadmin':
        source                   => $phpmyadmin::install_source,
        deploy_root              => $phpmyadmin::real_install_destination,
        predeploy_customcommand  => $phpmyadmin::install_precommand,
        postdeploy_customcommand => $phpmyadmin::real_install_postcommand,
        report_email             => 'root',
        auto_deploy              => true,
        enable                   => true,
      }
    }

    default: { }

  }

}
