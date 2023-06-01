# Kubernetes

## Error: ImagePullBackOff / Failed to pull image

#### Lösung 1

Port `:443` fehlt in der Definition des Images

#### Lösung 2

ImagePullSecrets oder den Service Account angeben, z.B. in der values.yml bei Verwendung von Helm

## Force Delete Pod

```shell
kubectl delete pod POD_NAME --grace-period=0 --force --namespace YOUR_NAMESPACE
```

## Accessing Multiple Kubernetes Clusters from console

```shell
# in .zshrc
export KUBECONFIG=$KUBECONFIG:~/.kube/config:~/.kube/other-config
  
# You can switch the context like so:
kubectl config use-context SOME_CONTEXT_NAME
```

## Manually starting a k8s cron job
```shell
kubectl -n YOUR_NAMESPACE create job --from=cronjob/CURRENTLY_DEPLOYED_CRON_JOB NAME_OF_MANUAL_JOB_RUN
```

## Copy a secret from one namespace to another
```shell
kubectl get secret SECRET_NAME --namespace=YOUR_ORIGIN_NAMESPACE -o yaml | sed 's/namespace: .*/namespace: YOUR_TARGET_NAMESPACE/' | kubectl apply --namespace=YOUR_TARGET_NAMESPACE -f -
```
