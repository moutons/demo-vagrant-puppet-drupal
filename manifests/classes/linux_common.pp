class linux_common {
  exec { "yum-update":
    command => "/usr/bin/yum -y update"
  }
  # Require update for every Package command
  Exec["yum-update"] -> Package <| |>
  Package["puppet"] -> Augeas <| |>
  Package["augeas-libs"] -> Augeas <| |>

  $augeaspackages = [ "augeas", "augeas-libs", "puppet", "make", "postfix", "unzip", ]
  package { $augeaspackages:
    ensure => installed,
  }
  file { "/etc/postfix/main.cf":
    ensure  => file,
    replace => true,
    content => "myhostname = ${fqdn}
    inet_interfaces = loopback-only
    default_transport = error:postfix configured to not route email",
    require => Package['postfix']
  }
  exec { 'reload ssh':
    command     => "/etc/init.d/sshd restart",
    refreshonly => true,
  }
  augeas { 'ssh_allow_agent_forwarding':
    context => '/files/etc/ssh/sshd_config',
    changes => [
      'set AllowAgentForwarding yes',
    ],
    notify => Exec['reload ssh']
  }
}
