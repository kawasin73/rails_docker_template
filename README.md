# docker rails template

## to initialize from base

```bash
script/init
```

## to bootstrap after clone

```bash
script/bootstrap
```

## to develop

```bash
docker-compose up -d
docker-compose exec spring rails db:migrate
```
