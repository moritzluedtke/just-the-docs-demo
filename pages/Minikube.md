# Minikube

### Run service build locally in minikube

```shell script
# Go into service dir
cd /service

# Build project and docker image
mvn -s settings.xml clean package docker:build

# Run it in minikube
# Local Kubectl needs to point to minikube (context needs to be set)
kubectl run service --image=service:YOUR-VERSION --image-pull-policy=Never \
--env="SPRING_PROFILES_ACTIVE=dev" \
--env="ES_HOST=localhost:9200" \
--env="ES_SOCKET_TIMEOUT=500" \
--env="ES_INDEX_NAME=de_product"
```

