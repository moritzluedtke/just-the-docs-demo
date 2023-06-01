#!/bin/bash
  kubectl get csr smile-stage-cert -o jsonpath='{.status.certificate}' \
    | base64 --decode > smile-stage-cert.crt
