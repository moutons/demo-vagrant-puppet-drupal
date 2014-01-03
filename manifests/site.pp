file { '/etc/profile.d/vagrant_ruby.sh':
  ensure => absent,
}
Exec { path => [
    "/usr/local/sbin",
    "/usr/local/bin",
    "/usr/sbin",
    "/usr/bin",
    "/sbin:/bin",
  ]
}

import "classes/*"
import "nodes.pp"
