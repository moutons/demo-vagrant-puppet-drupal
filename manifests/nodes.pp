node default {
  include linux_common
  include drupal
  include devel

  add_user { drupalu:
    email    => 'drupalu@localhost',
    uid      => $vgrtuid,
    password => 'drupalu',
  }
  add_ssh_key { drupalu:
    pubkey => "INSERTPUBKEYHERE",
    type => "KEYTYPE", # this will be ssh-rsa OR ssh-dss
  }

  file {"/home/drupalu/.gitconfig":
    ensure  => present,
    content => "", # copy ~/.gitconfig from your main dev box.. maybe..
    owner   => drupalu,
    group   => drupalu,
    mode    => 600,
    require => File["/home/drupalu"]
  }
}
