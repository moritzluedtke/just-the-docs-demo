echo "==========================================="
echo "---- Renewing all Ingress certificates ----"
echo "==========================================="
echo ""

echo "----------------------------------------------"
echo "----- Target k8s cluster information -----"
kubectl cluster-info
echo "----------------------------------------------"
echo ""

# --------- Dev --------
echo "----------------------------------------------"
echo "Recreating Ingress certificate for dev ..."
echo "----------------------------------------------"

kubectl delete csr dev-cert --ignore-not-found true

chmod +x dev/generate-key.sh && dev/generate-key.sh
chmod +x dev/create-csr-in-k8s.sh && dev/create-csr-in-k8s.sh

kubectl certificate approve dev-cert

chmod +x dev/retrieve-cert-from-k8s.sh && dev/retrieve-cert-from-k8s.sh

kubectl delete secret --namespace dev dev-cert --ignore-not-found true
kubectl create secret tls dev-cert --cert=dev-cert.crt --key=dev-cert-key.pem --dry-run=client --namespace dev -o yaml | kubectl apply -f -

kubectl delete -f ../../ingress/ingress-dev.yml || true
kubectl apply -f ../../ingress/ingress-dev.yml


# --------- Stage --------
echo "----------------------------------------------"
echo "Recreating Ingress certificate for stage ..."
echo "----------------------------------------------"
kubectl delete csr stage-cert --ignore-not-found true

chmod +x stage/generate-key.sh && stage/generate-key.sh
chmod +x stage/create-csr-in-k8s.sh && stage/create-csr-in-k8s.sh

kubectl certificate approve stage-cert

chmod +x stage/retrieve-cert-from-k8s.sh && stage/retrieve-cert-from-k8s.sh

kubectl delete secret --namespace stage stage-cert --ignore-not-found true
kubectl create secret tls stage-cert --cert=stage-cert.crt --key=stage-cert-key.pem --dry-run=client --namespace stage -o yaml | kubectl apply -f -

kubectl delete -f ../../ingress/ingress-stage.yml || true
kubectl apply -f ../../ingress/ingress-stage.yml


# --------- Cleanup --------
echo "----------------------------------------------"
echo "Removing certificates from machine ..."
echo "----------------------------------------------"

rm *-cert.crt
rm *-cert.csr
rm *-cert-key.pem
