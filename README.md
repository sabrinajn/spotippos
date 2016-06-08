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

Testes
-----------------

Utilizei o rspec para escrever os testes unitários, segue o comando para executar os testes:
```sh
$ docker-compose run web bundle exec rspec
```

Para os testes de aceitação, eu utilizei o cucumber. Execute-o com o seguinte comando:
```sh
$ docker-compose run web bundle exec cucumber
```

Executar
-----------------

### 1. Criando imóveis em Spotippos

 request:
```sh
$ curl -H "Content-Type: application/json" -X POST http://$(docker-machine ip default):9292/properties -d '{"x": 667,"y": 556,"title": "Imóvel código 1, com 5 quartos e 4 banheiros","price": 1250000,"description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.","beds": 4,"baths": 3,"squareMeters": 210}'
```

response:
```
 HTTP/1.1 201 Created
 Content-Type: text/html;charset=utf-8
 Content-Length: 8

{ "id" : 1 }
```

### 2. Mostre um imóvel específico em Spotippos

request:
```sh
$ curl -H "Content-Type: application/json" -X GET http://$(docker-machine ip default):9292/properties/1
```

response:
```
 HTTP/1.1 200 OK
 Content-Type: text/html;charset=utf-8
 Content-Length: 230

  { "id":1,
    "title":"Imóvel código 1, com 5 quartos e 4 banheiros",
    "price":1250000,
    "description":"Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
    "x":222,
    "y":444,
    "beds":4,
    "baths":3,
    "provinces":["Scavy"],
    "squareMeters":210
  }
```

### 3. Busque imóveis em Spotippos

request:
```sh
$ curl -H "Content-Type: application/json" -X GET "http://$(docker-machine ip default):9292/properties?ax=100&ay=700&bx=700&by=300"
```

response:
```
 HTTP/1.1 200 OK
 Content-Type: text/html;charset=utf-8
 Content-Length: 497

{ "foundProperties":1,
  "properties":[
        {
          "id":1,
          "title":"Imóvel código 1, com 5 quartos e 4 banheiros",
          "price":1250000,
          "description":"Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
          "x":222,
          "y":444,
          "beds":4,
          "baths":3,
          "provinces":["Scavy"],
          "squareMeters":210
        }
    ]
}
```
