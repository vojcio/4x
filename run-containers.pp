## install and configure redis
include 'docker'
docker::image { 'redis': }
docker::image { 'logstash':}
docker::image { 'rabbitmq':}

docker::run { 'redis1':
  image        	=> 'redis',
  dns          	=> ['8.8.8.8', '8.8.4.4'],
}

docker::run { 'logstash-fr':
  image		=> 'logstash',
  dns		=> ['8.8.8.8', '8.8.4.4'],
  volumes       => ['/root/4x/logst-fr:/config-dir'],
  tty           => true,
  command 	=> '-f /config-dir/logstash.conf',
  links		=> ['redis1:redis'],
  depends         => [ 'redis1' ],
}

docker::run { 'logstash-back':
  image         => 'logstash',
  dns           => ['8.8.8.8', '8.8.4.4'],
  volumes       => ['/root/4x/logst-back:/config-dir'],
  tty           => true,
  command       => '-f /config-dir/logstash.conf',
  depends         => [ 'redis1' ],
}
