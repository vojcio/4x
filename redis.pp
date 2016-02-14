## install and configure redis
docker::image { 'redis': }

docker::run { 'redis1':
  image        => 'redis',
  dns          => ['8.8.8.8', '8.8.4.4'],
}
