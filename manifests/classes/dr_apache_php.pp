class dr_apache_php {
  include dr_mysql
  include apache
  class {'apache::mod::php':
    require => Package["php5"]
  }
  apache::loadmodule{'rewrite':
  }
  
  $phppackages = [ "php-mysql", "php-imap", "php-gd", "php-devel", "php-pear", "php-pecl-apc", "php-cli", "php-common", "augeas", ]
  
  package { php:
    ensure => installed,
  }
  package { $phppackages:
    ensure  => installed,
    require => Package["php"]
  }
  # apc
  file { '/etc/php.d/apc.ini':
    ensure  => "present",
    require => Package['php-pecl-apc'],
  }
  # php.ini
  augeas { 'php_dev_config':
    context => "/files/etc/php.ini/PHP"
    changes => [
      'set memory_limit 512M',
      'set max_execution_time 60',
      'set max_input_time 90',
      'set error_reporting E_ALL | E_STRICT',
      'set display_errors On',
      'set display_startup_errors On',
      'set html_errors On',
      'set error_prepend_string <pre>',
      'set error_apend_string </pre>',
      'set post_max_size 128M',
      'set upload_max_filesize 128M',
    ],
    #require => [ Package['php'], Package['augeas'] ],
    require => Package['php'],
    notify  => Exec['reload apache'],
  }
}
