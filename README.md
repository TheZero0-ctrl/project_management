# README

## Project Management

## Getting started

To get started with the app, clone the repo and follow following step

First, install postgis

```
$ sudo apt-get install postgis postgresql-12-postgis-3
```
You can replace  postgresql-12 with your version of postgresql

Next, install gems

```
$ bundle install
```
Next, create database

```
$ rails db:create
```
Next, enable PostGIS on the newly created database by running the following commands:

```
psql database_name -c "CREATE EXTENSION postgis;"
psql database_name -c "CREATE EXTENSION postgis_topology;"
```

Next, migrate the database:
```
$ rails db:migrate
```
Next, seed the database
```
$ rails db:seed
```
Then, run server
```
$ ./bin/dev
```
For login information look at the db/seeds.rb file