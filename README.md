# gogRPC
gRPC GoLang implementation example

# gRPC reflection:
enable reflection:
```
s := grpc.NewServer(opts...)
	reflection.Register(s) # here
	greetpb.RegisterGreetServiceServer(s, &server{})
```
install the Evans gRPC CLI client https://github.com/ktr0731/evans

```
evans -p 50051 -r # connect to your gRPC server

  ______
 |  ____|
 | |__    __   __   __ _   _ __    ___
 |  __|   \ \ / /  / _. | | '_ \  / __|
 | |____   \ V /  | (_| | | | | | \__ \
 |______|   \_/    \__,_| |_| |_| |___/

 more expressive universal gRPC client


greet.GreetService@127.0.0.1:50051> show package
+---------+
| PACKAGE |
+---------+
| greet   |
+---------+

greet.GreetService@127.0.0.1:50051> show service
+--------------+----------------+-----------------------+------------------------+
|   SERVICE    |      RPC       |      REQUESTTYPE      |      RESPONSETYPE      |
+--------------+----------------+-----------------------+------------------------+
| GreetService | Greet          | GreetRequest          | GreetResponse          |
|              | GreetManyTimes | GreetManyTimesRequest | GreetManyTimesResponse |
|              | LongGreet      | LongGreetRequest      | LongGreetResponse      |
|              | GreetEveryone  | GreetEveryoneRequest  | GreetEveryoneResponse  |
+--------------+----------------+-----------------------+------------------------+

greet.GreetService@127.0.0.1:50051> show message
+------------------------+
|        MESSAGE         |
+------------------------+
| Greeting               |
| GreetRequest           |
| GreetResponse          |
| GreetManyTimesRequest  |
| GreetManyTimesResponse |
| LongGreetRequest       |
| LongGreetResponse      |
| GreetEveryoneRequest   |
| GreetEveryoneResponse  |
+------------------------+

greet.GreetService@127.0.0.1:50051> desc Greeting
+------------+-------------+
|   FIELD    |    TYPE     |
+------------+-------------+
| first_name | TYPE_STRING |
| last_name  | TYPE_STRING |
+------------+-------------+

greet.GreetService@127.0.0.1:50051> package default
package: default: default not found: unknown package

greet.GreetService@127.0.0.1:50051> show package
+---------+
| PACKAGE |
+---------+
| greet   |
+---------+

greet.GreetService@127.0.0.1:50051> package greet

greet.GreetService@127.0.0.1:50051> call Greet
greeting::first_name (TYPE_STRING) => youssef
greeting::last_name (TYPE_STRING) => lamani
{
  "result": "Helloyoussef"
}

greet.GreetService@127.0.0.1:50051> show package
+---------+
| PACKAGE |
+---------+
| greet   |
+---------+

greet.GreetService@127.0.0.1:50051> desc Greeting
+------------+-------------+
|   FIELD    |    TYPE     |
+------------+-------------+
| first_name | TYPE_STRING |
| last_name  | TYPE_STRING |
+------------+-------------+

greet.GreetService@127.0.0.1:50051> call GreetManyTimes
greeting::first_name (TYPE_STRING) => youssef
greeting::last_name (TYPE_STRING) => lamani
{
  "result": "Hello youssef number 0"
}

{
  "result": "Hello youssef number 1"
}

{
  "result": "Hello youssef number 2"
}

{
  "result": "Hello youssef number 3"
}

{
  "result": "Hello youssef number 4"
}

{
  "result": "Hello youssef number 5"
}

{
  "result": "Hello youssef number 6"
}

{
  "result": "Hello youssef number 7"
}

{
  "result": "Hello youssef number 8"
}

{
  "result": "Hello youssef number 9"
}

```

# TLS bootstrap:

```
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
```
# Enable TLS at the server level:

```
certFile := "tls/server.crt"
		keyFile := "tls/server.pem"
		creds, sslErr := credentials.NewServerTLSFromFile(certFile, keyFile)
		if sslErr != nil {
			log.Fatalf("Failed loading certificates: %v", sslErr)
			return
```

# Enable TLS at the client level:

```
certFile := "tls/ca.crt"
		creds, sslErr := credentials.NewClientTLSFromFile(certFile, "")
		if sslErr != nil {
			log.Fatal("Error while loading CA trust certificate: %v", sslErr)
			return
```
