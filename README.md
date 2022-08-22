# README

$ docker compose run --no-deps web rails new . --force --database=postgresql

$ docker compose build

$ docker compose up

Finally, you need to create the database. In another terminal, run:

$ docker compose run web rake db:create
