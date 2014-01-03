class drupal {
  include dr_mysql
  include dr_apache_php

  exec { 'install drush':
    command => '/usr/bin/pear channel-discover pear.drush.org && /usr/bin/pear install drush/drush',
    require => Package['php-console-table'],
    creates => '/usr/bin/drush'
  }

  package { 'php-console-table':
    ensure  => installed,
    require => Package['php-pear']
  }
  file { "/var/www":
    ensure => "directory"
  }
  apache::vhost { $fqdn:
    priority      => '10',
    vhost_name    => '*',
    port          => '80',
    docroot       => "/var/www/${fqdn}/",
    override      => 'All',
    serveradmin   => "admin@${fqdn}",
    serveraliases => ["www.${fqdn}",],
    notify        => Exec['reload apache']
  }
  cron { drupal:
    command => "/usr/bin/drush -r ${fqdn} cron >/dev/null",
    user    => www-data,
    minute  => 0,
    require => Exec['install drush']
  }
  exec {'reload apache':
    command     => "/etc/init.d/httpd reload",
    refreshonly => true,
  }
  # update /etc/hosts file
  host { '/etc/hosts clean':
    ip     => '127.0.1.1',
    name   => $hostname,
    ensure => absent
  }
  # set aliased vhost to eth0 IP
  host { '/etc/hosts drupal':
    ip           => $ipaddress_eth0,
    ensure       => present,
    name         => $fqdn,
    host_aliases => ["www.${fqdn}", $hostname],
  }
}




