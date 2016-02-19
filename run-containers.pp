## install and configure redis

include 'docker'
docker::image { 'rabbitmq':}
docker::image { 'kingsquare/tunnel':}

#5672
docker::run { 'rabbit':
  image		=> 'rabbitmq',
  dns           => ['8.8.8.8', '8.8.4.4'],
  hostname        => 'rabbit1',
}

docker::run { 'tunnel':
  image		=> 'kingsquare/tunnel',
  volumes	=> '$SSH_AUTH_SOCK:/ssh-agent',
  # *:[$exposed_port]:[$destination]:[$destination_port] [$user@][$server]
  tty		=> true,
  command	=> '*.5672:127.0.0.1:5673 root@localhost',
}


