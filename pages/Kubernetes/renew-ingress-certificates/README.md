# Renew Kubernetes Ingress Certificates

> A brief interruption of each Ingress service is unavoidable because we need to recreate each ingress and secret.

### Locally

> Local kubectl must point to the correct environment!

You need `cfssl`/`cfssljson` to update the certificates. Check if it is installed by running the following command in your terminal: `cfssl`

You can install both commands by running: `brew install cfssl`

Execute the following commands, and you are good to go:

```shell
cd Kubernetes/renew-ingress-certificates 
chmod +x renew-all-certificates.sh && ./renew-all-certificates.sh
```
