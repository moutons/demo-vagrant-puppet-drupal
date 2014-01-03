class devel {
  package { screen:
    ensure => installed,
  }
  package { mailutils:
    ensure => installed,
  }
  package { vim-enhanced:
    ensure => installed,
  }
  package { git:
    ensure => installed,
  }
  package { php5-xdebug:
    ensure => installed,
  }
}
