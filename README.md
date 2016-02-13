# Chatroom

## Requirements

* `gem install redis`

## Starting the servers
You need 4 terminal tabs with 4 different processes running in each one.

1. `bundle exec puma -p 28080 cable/config.ru` This starts the action cable server
2. `./bin/rails server` This starts the rails server
3. `redis-server` This starts the redis pubsub
4. `elasticsearch --path.conf=/usr/local/opt/elasticsearch/config` This starts the elastic search server
