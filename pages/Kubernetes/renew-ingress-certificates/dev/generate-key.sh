#!/bin/bash
cat <<EOF | cfssl genkey - | cfssljson -bare dev-cert
{
  "hosts": [
    "my-address.net"
  ],
  "CN": "my-address.net",
  "key": {
    "algo": "ecdsa",
    "size": 256
  }
}
EOF
