# README

### Intiial docker build
```bash
docker-compose up --build
```

### seed the db
```bash
docker-compose run --rm app rails db:seed
```

### boot app once build
```bash
docker-compose up
```

### run the specs
```bash
docker-compose run -e RAILS_ENV=test --rm app rspec
```
