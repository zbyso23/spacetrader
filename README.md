# README

## Sandbox Setup
```
rvm install 3.3.7
rvm use 3.3.7 --default
gem install rails -v 7.0.8.7

gem uninstall concurrent-ruby
gem install concurrent-ruby -v 1.3.4

rails _7.0.8.7_ new . --database=sqlite3

rails db:create
rails db:migrate

rails generate model User name:string email:string
rails generate migration CreatePlayers
rails generate migration CreateGoods
rails generate migration CreatePlanets
```

**Postgres:**
```
apt install postgresql postgresql-contrib libpq-dev -y
systemctl enable postgresql
systemctl start postgresql
systemctl status postgresql

su - postgres

createuser -s myuser
createdb myapp_development -O myuser

psql

postgres=# \password myuser
```

`vim /etc/postgresql/16/main/pg_hba.conf`
```
host    all             all             127.0.0.1/32            scram-sha-256
->
host    all             all             127.0.0.1/32            md5

host    all             all             ::1/128                 scram-sha-256
->
host    all             all             ::1/128                 md5
```

## API call
**basic**
```
curl -X GET "http://localhost:3000/players/5/inventory_summary" \
  -H "Accept: application/vnd.api+json"
```

**with good**
```
curl -X GET "http://localhost:3000/players/5/inventory_summary?include=good" \
  -H "Accept: application/vnd.api+json"
```



This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
