# Sistemas de Rotas - Fretadão API

#### Environment

Caso queira um passo a passo de instalação de como configurar o seu ambiente, pode consultar o site do [GoRails](https://gorails.com/setup/ubuntu/18.10).

##### Heroku

##### Documentação da API: 

[https://router-planner.herokuapp.com/api-docs](https://router-planner.herokuapp.com/api-docs)

```
Rails Version: 6.0.2
Ruby Version: 2.5.7
Postgres version: 9.5 or higher
```

ou caso queira utilizar o docker, o projeto suporta, basta instalar o Docker e o Docker Compose, pode consultar o site do [Docker](https://docs.docker.com/compose/install/)

#### Setup

Lembre-se de conferir o arquivo de `database.yml`.

```sh
$ cp config/database.yml.sample config/database.yml
$ bin/setup
```

Para utilizar o docker siga os passos abaixo:

Configurar o `config/database.yml`, adicionando ao `host` o nome o serviço `db`
```yml
default: &default
  adapter: postgresql
  encoding: utf8
  pool: <%= ENV.fetch("DB_POOL") || 5 %>
  username: postgres
  password: rodolfo
  host: db
  reconnect: true
```

Para colocar o servidor online, utilize o comando no Linux e aguarde, será efetuado o download dos layers/images

```sh
  $ docker-compose up --build
```

O docker acaba sendo mais lento no Mac, então pode-se utilizar com o comando:

```sh
$ docker-compose -f docker-compose-mac.yml up --build
```

Para executar o `rubocop` ou `rspec spec`, você precisa estar com os containers em execução, execute o comando abaixo.

```sh
  $ docker exec -it fundacao-estudar_app_1 sh
```
O terminal estará disponível para executar os comandos abaixo:

Executar o rubocop

```
 $ rubocop -a
```

Executar os testes

```
 $ rspec spec
```
Quando executamos o rspec, automaticamente o coverage é executado também, então podemos verificar a cobertura de testes, basta acessar a pasta `/coverage` na raiz do projeto e abrir o html `index.html` e estará disponível os arquivos que estão cobertos ou não.


```
localhost:3000/api-docs
```

#### Como usar a api da documentação

[![Image from Gyazo](https://i.gyazo.com/7ffcd82bd8bec3288a8c9c30782ddac8.gif)](https://gyazo.com/7ffcd82bd8bec3288a8c9c30782ddac8)

[![Image from Gyazo](https://i.gyazo.com/181595251dd9ffa8ae97c291151394ab.gif)](https://gyazo.com/181595251dd9ffa8ae97c291151394ab)

[![Image from Gyazo](https://i.gyazo.com/ddf68e01db77530ed2d5044d6c5349a7.gif)](https://gyazo.com/ddf68e01db77530ed2d5044d6c5349a7)

[![Image from Gyazo](https://i.gyazo.com/63dfcd1cc381a7813524527b01266806.gif)](https://gyazo.com/63dfcd1cc381a7813524527b01266806)

[![Image from Gyazo](https://i.gyazo.com/9bf06dd94857623ce462970ef0385de1.gif)](https://gyazo.com/9bf06dd94857623ce462970ef0385de1)

#### Descrição

Estamos avaliando uma série de coisas, que incluem o aspecto de design da sua solução, mas na maioria das vezes, estamos procurando boas práticas de codificação e suas habilidades de programação orientada a objetos. Também esperamos por testes automatizados.

#### Problema

O Fretadão está desenvolvendo um novo sistema de rotas e sua ajuda é muito importante neste momento. Sua tarefa será desenvolver o
novo sistema visando sempre o menor custo.

#### Input

Para popular sua base de dados o sistema precisa expor um serviço (Webservice) que aceite o formato de malha logística (conforme exemplo abaixo), nesta mesma requisição o requisitante deverá informar um nome para este mapa. 

É importante que os mapas sejam persistidos para evitar que a cada novo deploy todas as informações desapareçam. O formato de malha logística é bastante simples, cada linha mostra uma rota: ponto de origem, ponto de destino e distância entre os pontos em quilômetros, separados por espaços:

A B 10

B D 15

A C 20

C D 30

B E 50

D E 30

Um exemplo de entrada seria, mapa `SP`, rotas `["A B 10", "B D 15", "A C 20", ...]`.

Com os mapas carregados o requisitante irá procurar o menor custo em seu trajeto, para isso ele deve informar o mapa, nome do ponto de
origem, nome do ponto de destino, autonomia do ônibus (km/l) e o valor do litro do combustivel, sua tarefa é criar este serviço também.

Um exemplo de entrada seria, mapa `SP`, origem `A`, destino `D`, autonomia `10`, valor do litro `2,50`; a resposta seria a rota `A B D` com custo de `6,25`.