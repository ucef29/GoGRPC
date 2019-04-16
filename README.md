# gogRPC
gRPC GoLang implementation example

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
