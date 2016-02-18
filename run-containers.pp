## install and configure redis

include 'docker'
docker::image { 'redis': }
docker::image { 'logstash':}
docker::image { 'rabbitmq':}

docker::run { 'redis1':
  image        	=> 'redis',
  dns          	=> ['8.8.8.8', '8.8.4.4'],
}

docker::run { 'logstash-back':
  image         => 'logstash',
  dns           => ['8.8.8.8', '8.8.4.4'],
  volumes       => ['/root/4x/logst-back:/config-dir'],
  tty           => true,
  links		=> ['redis1:redis', 'rabbit1:rabbitmq'],
  command       => '-f /config-dir/logstash.conf',
  depends         => [ 'redis1', 'rabbit1' ],
}

docker::run { 'rabbit1':
  image		=> 'rabbitmq',
  dns           => ['8.8.8.8', '8.8.4.4'],
  hostname        => 'rabbit1',
}
