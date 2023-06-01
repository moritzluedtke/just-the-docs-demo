# Toxiproxy

https://github.com/Shopify/toxiprox

## Install

Follow the instructions for brew in the github README.

## Usage

```shell
#### Start toxiproxy-server ####
toxiproxy-server


#### Create a proxy ####

# Example
toxiproxy-cli create -l NEW_ADDRESS_TO_THIS_PROXY -u TARGET elasticsearch_local

toxiproxy-cli create -l localhost:1234 -u localhost:9200 elasticsearch_local


#### Add a toxic (latency, slow_rate, ...) ####
# Adding multiple toxics is possible #

# Example
toxiproxy-cli toxic add -n SOME_NAME -t TOXIC_NAME -a ATTRIBUTE_NAME=VALUE NAME_OF_PROXY

toxiproxy-cli toxic add -n es_latency -t latency -a latency=11000 elasticsearch_local
toxiproxy-cli toxic update -n es_latency -a latency=11000 elasticsearch_local
toxiproxy-cli toxic delete -n es_latency elasticsearch_local

toxiproxy-cli toxic add -n es_timeout -t timeout -a timeout=0 elasticsearch_local
toxiproxy-cli toxic delete -n es_timeout elasticsearch_local

toxiproxy-cli toxic add -n es_bandwidth -t bandwidth -a rate=5 elasticsearch_local
toxiproxy-cli toxic d -n es_bandwidth elasticsearch_local
```
