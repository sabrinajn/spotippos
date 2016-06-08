

Deploy
-------------

Instalar o docker, se preferir utilizando o homebrew

```sh
$ brew cask install virtualbox
$ brew install docker docker-machine docker-compose
```

Inicializando o docker
```sh
$ docker-machine create --driver virtualbox default
$ eval $(docker-machine env default)
$ docker-compose build
$ docker-compose up -d
```

Criando o banco e as tabelas

```sh
$ docker-compose run web rake db:create
$ docker-compose run web rake db:migrate_up
```


curl -H "Content-Type: application/json" -X GET 'http://localhost:9292/properties?ax=0&ay=600&bx=500&by=300'


curl -H "Content-Type: application/json" -X POST http://localhost:9292/properties -d '{"x": 222,"y": 444,"title": "Imóvel código 1, com 5 quartos e 4 banheiros","price": 1250000,"description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.","beds": 4,"baths": 3,"squareMeters": 210}'

