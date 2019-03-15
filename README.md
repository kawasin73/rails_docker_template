# docker rails template

Docker template for Rails app or Rails + Webpacker app development.

## Use for development

This template use [entrykit](https://github.com/progrium/entrykit) to execute `bundle install` on ENTRYPOINT of Docker.

No re-build docker image on changing Gemfile because bundled gems is cached in Docker Volume.

To develop rails app, use following commands.

```bash
script/bootstrap
docker-compose exec rails bash
```

You can execute any commands in docker container.

## Getting started

You can build rails app from template like this.

```bash
git clone https://github.com/kawasin73/rails_docker_template.git .
git checkout origin/base/ruby-2.5.1-rails-5.2.0
git branch -d master && git checkout -b master
script/init && script/bootstrap

docker-compose up -d
docker-compose exec rails bash
# access to http://localhost:3000
```

You can also use built app like this.

```bash
git clone https://github.com/kawasin73/rails_docker_template.git .
git checkout origin/ruby-2.5.1-rails-5.2.0
git branch -d master && git checkout -b master
script/bootstrap
# initialize credentials.yml.enc
docker-compose run --rm rails bin/rails credentials:edit

docker-compose up -d
docker-compose exec rails bash
# access to http://localhost:3000
```

## Branches

This repository have 4 types of branch, `master`, `webpacker`, `base`, `built`.
If you want start development, Use `built` branch.

- master
  - `master` branch is branch for develop rails app template.
- webpacker
  - `webpacker` branch is master branch of `rails + webpacker` app.

### base branch

`base/ruby-RUBY_VERSION-rails-RAILS_VERSION` branch has only template.
base branch have one `Initial Commit` commit.

Please build application on your local environment.

```bash
git clone https://github.com/kawasin73/rails_docker_template.git .
git checkout origin/base/ruby-2.5.1-rails-5.2.0
git branch -d master && git checkout -b master
script/init && script/bootstrap
```

- [base/ruby-2.5.1-rails-5.2.0](https://github.com/kawasin73/rails_docker_template/tree/base/ruby-2.5.1-rails-5.2.0)
- [base/ruby-2.5.1-rails-5.2.0-webpack](https://github.com/kawasin73/rails_docker_template/tree/base/ruby-2.5.1-rails-5.2.0-webpack)
- [base/ruby-2.5.1-rails-5.2.1](https://github.com/kawasin73/rails_docker_template/tree/base/ruby-2.5.1-rails-5.2.1)
- [base/ruby-2.5.1-rails-5.2.1-webpack](https://github.com/kawasin73/rails_docker_template/tree/base/ruby-2.5.1-rails-5.2.1-webpack)
- [base/ruby-2.6.1-rails-5.2.2](https://github.com/kawasin73/rails_docker_template/tree/base/ruby-2.6.1-rails-5.2.2)
- [base/ruby-2.6.1-rails-5.2.2-webpack](https://github.com/kawasin73/rails_docker_template/tree/base/ruby-2.6.1-rails-5.2.2-webpack)

### built branch

`ruby-RUBY_VERSION-rails-RAILS_VERSION` branch has built application.

Please initialize secrets and start to development.

```bash
git clone https://github.com/kawasin73/rails_docker_template.git .
git checkout origin/ruby-2.5.1-rails-5.2.0
git branch -d master && git checkout -b master
script/bootstrap
# initialize credentials.yml.enc
docker-compose run --rm rails bin/rails credentials:edit
```

- [ruby-2.5.1-rails-5.2.0](https://github.com/kawasin73/rails_docker_template/tree/ruby-2.5.1-rails-5.2.0)
- [ruby-2.5.1-rails-5.2.0-webpack](https://github.com/kawasin73/rails_docker_template/tree/ruby-2.5.1-rails-5.2.0-webpack)
- [ruby-2.5.1-rails-5.2.1](https://github.com/kawasin73/rails_docker_template/tree/ruby-2.5.1-rails-5.2.1)
- [ruby-2.5.1-rails-5.2.1-webpack](https://github.com/kawasin73/rails_docker_template/tree/ruby-2.5.1-rails-5.2.1-webpack)
- [ruby-2.6.1-rails-5.2.2](https://github.com/kawasin73/rails_docker_template/tree/ruby-2.6.1-rails-5.2.2)
- [ruby-2.6.1-rails-5.2.2-webpack](https://github.com/kawasin73/rails_docker_template/tree/ruby-2.6.1-rails-5.2.2-webpack)

## License

MIT
