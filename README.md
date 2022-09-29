# Paraffin
[![Ruby Style Guide](https://img.shields.io/badge/code_style-rubocop-brightgreen.svg)](https://github.com/rubocop/rubocop) [![Ruby Style Guide](https://img.shields.io/badge/code_style-community-brightgreen.svg)](https://rubystyle.guide)
[![Maintainability](https://api.codeclimate.com/v1/badges/a8924cfe1a51fd8463d7/maintainability)](https://codeclimate.com/github/rtichauerv/paraffin/maintainability) [![Test Coverage](https://api.codeclimate.com/v1/badges/a8924cfe1a51fd8463d7/test_coverage)](https://codeclimate.com/github/rtichauerv/paraffin/test_coverage)


## The Team

Created by the Queens Team 👑 at the FIN bootcamp by Fintual.


## The Stack

### Main players

- Ruby
- Rails
- Postgres
- Rspec

## Getting Started

0. Before everything, you should have Docker and Docker Compose in your computer (Docker desktop includes both).

1. Clone this repo and cd into your directory.
    
    git clone git@github.com:rtichauerv/paraffin.git && cd paraffin

2. In another terminal window, build and run your app with Compose.

    `$ docker compose up --build`

3. You need to create the database. In another terminal, run:

    `$ docker compose run web rake db:create db:migrate db:seed`

4. Finally, enter http://localhost:3000/ in a browser to see the application running.


## Deploy 🚀

https://back-queens.herokuapp.com/

## Autores ✒️

-   **Vanessa Pulgar** - _Developer_ - [vpulgar](https://github.com/vpulgar)
-   **Cecilia Ramallo** - _Developer_ - [cecyramallo](https://github.com/cecyramallo)
-   **Isabel Vega** - _Developer_ - [isavega](https://github.com/isavega)
