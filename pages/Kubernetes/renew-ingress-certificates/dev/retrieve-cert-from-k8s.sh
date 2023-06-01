#!/bin/bash
  kubectl get csr dev-cert -o jsonpath='{.status.certificate}' | base64 --decode > dev-cert.crt
