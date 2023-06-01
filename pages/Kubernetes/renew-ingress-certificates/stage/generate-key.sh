#!/bin/bash
cat <<EOF | cfssl genkey - | cfssljson -bare smile-stage-cert
{
  "hosts": [
    "lab-dev-stage.bonprix.work"
  ],
  "CN": "lab-dev-stage.bonprix.work",
  "key": {
    "algo": "ecdsa",
    "size": 256
  }
}
EOF
