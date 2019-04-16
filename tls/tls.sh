
# output files
# ca.key: certificate authority private key file (this shouldn't be shared in real-life)
# ca.crt: certificate authority trust certificate (this shouldn't be shared with users in real-life)
# server.key: server private key, password protected (this shouldn't be shared)
# server.csr: server certificate siging request (this should be shared with the CA owner)
# server.crt: server certificate signed by the CA (this would be sent back by the CA owner) - keep on server
# server.pem: conversion of server.key into a format gRPC likes (this shouldn't be shared)

# summary
# Private files: ca.key, server.key, server.pem, server.crt
# "share" files: ca.crt (needed by the client), server.csr (needed by the CA)

SERVER_CN=localhost

openssl genrsa -passout pass:1111 -des3 -out ca.key 4096
openssl req -passin pass:1111 -new -x509 -days 365 -key ca.key -out ca.crt -subj "/CN=${SERVER_CN}"

openssl genrsa -passout pass:1111 -des3 -out server.key 4096

openssl req -passin pass:1111 -new -key server.key -out server.csr -subj "/CN=${SERVER_CN}"

openssl x509 -req -passin pass:1111 -days 365 -in server.csr -CA ca.crt -CAkey ca.key -set_serial 01 -out server.crt

openssl pkcs8 -topk8 -nocrypt -passin pass:1111 -in server.key -out server.pem