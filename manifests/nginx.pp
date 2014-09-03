# Class: phpmyadmin::nginx
#
# This class configures nginx for phpmyadmin installation
#
# == Usage
#
# This class is not intended to be used directly.
# It's automatically included by phpmyadmin
#
class phpmyadmin::nginx inherits phpmyadmin {

  nginx::vhost { $phpmyadmin::web_virtualhost :
    template => $phpmyadmin::real_web_server_template,
    docroot  => $phpmyadmin::real_data_dir,
  }

}
