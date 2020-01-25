# Sistemas de Rotas - Fretadão API

#### Environment

Caso queira um passo a passo de instalação de como configurar o seu ambiente, pode consultar o site do [GoRails](https://gorails.com/setup/ubuntu/18.10).

##### Documentação da API: 

[https://router-planner.herokuapp.com/api-docs](https://router-planner.herokuapp.com/api-docs)

```
Rails Version: 6.0.2
Ruby Version: 2.5.7
Postgres version: 9.5 or higher
```

##### Dependências

Para executar o projeto você precisará:

* Docker e o Docker Compose, pode consultar o site do [Docker](https://docs.docker.com/compose/install/)

## Setup the project

1. Instale as dependências abaixo:
2. `$ git clone git@github.com:rodolfopeixoto/fretadao-router-planner.git` - Clone o projeto
3. `$ cd fretadao-router-planner` - Acesse a pasta do projeto
4. Acesse a pasta `config/database.example.yml` e salve o nome como `database.yml` modifique para os dados do seu postgresql.
Se você desejar utilizar o docker configure o `host: db`, caso seja local, será `host: localhost`. Para usar o docker
o `database.example.yml`, já está configurado.

```
adapter: postgresql
  encoding: unicode
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  username: postgres
  password: master
  port: 5432
  host: db

```

5. `$ docker-compose build --no-cache` - Build as imagens do docker
6. Cria um setup inicial, instala as dependências and executa os tests
    - Primeira opção:
      * `$ docker-compose up -d` - Start os containers em background
      * `$ docker exec -it fretadao-router-planner_app_1 yarn` - Instalar as dependências
      * `$ docker exec -it fretadao-router-planner_app_1 rake db:setup` - Execute database migrations
      * `$ docker exec -it fretadao-router-planner_app_1 rspec` - Executar os specs para verificar se está tudo funcionando perfeitamente
    - Outras opções: 
      * `$ docker-compose run --rm app bash` - Run the container 
      * `$ bin/setup` - Executar a database migrations
      * `$ yarn` - Instalar as dependências 
      * `$ rspec spec` - Executar os specs
      * `$ exit` - Sair do container 
      * `$ docker-compose up -d` - Iniciar o containers em background

##### Mac usuários

In case you are a mac user:

1. Executar `sh .docker_script_for_mac.sh`
2. Use docker-compose-mac.yml to build your images

##### Executar a application

1. Open [http://localhost:3000/api-docs](http://localhost:3000/api-docs)

##### Executar spec e o coverage

- `$ docker exec -it fretadao-router-planner_app_1 rspec` to run the specs.

- `$ docker exec -it fretadao-router-planner_app_1 rspec` para gerar o coverage report, então abra o arquivo `coverage/index.html` no navegador.


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

Para popular sua base de dados o sistema precisa expor um serviço (appservice) que aceite o formato de malha logística (conforme exemplo abaixo), nesta mesma requisição o requisitante deverá informar um nome para este mapa. 

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