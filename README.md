# Chatroom

## Requirements

* `gem install redis`

## Starting the servers
You need 4 terminal tabs with 4 different processes running in each one.

1. `./bin/rails server` This starts the rails server and actioncable server
2. `redis-server` This starts the redis pubsub
3. `elasticsearch --path.conf=/usr/local/opt/elasticsearch/config` This starts the elastic search server
