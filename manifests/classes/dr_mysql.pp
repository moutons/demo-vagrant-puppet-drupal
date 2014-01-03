class dr_mysql {
  include mysql
  class { 'mysql::server':
    config_hash => { 'root_password' => 'vagrant' },
  }

  mysql::db { 'drupal':
    user     => 'drupal',
    password => 'drupal',
    host     => 'localhost',
    grant    => ['all'],
  }
}
