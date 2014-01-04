class dr_mysql {
  include mysql
  class { '::mysql::server':
    config_hash      => { 'root_password' => 'vagrant' },
    override_options => { 
      'mysqld' => { 
        'innodb_buffer_pool_size' => '128MB' 
      } 
    }
  }

  mysql::db { 'drupal':
    user     => 'drupal',
    password => 'drupal',
    host     => 'localhost',
    grant    => ['all'],
  }

  # using override_options hopefully
  # file { '/etc/mysql/conf.d/innodb':
}
