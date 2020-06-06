# crypto-letter

Naive email system write in bash.

Support by `openssl`.

# 密信

`bash` 脚本写的超简单的邮件系统。需要 `openssl` 支持。

## Generate your RSA key pair

If you already have one, you can skip this section.

Generate a private key using `3DES` with a pass `trousers` and length 1024.

```
openssl genrsa -out rsaprivatekey.pem -passout pass:trousers -des3 1024
```

Generate it's public key.

```
openssl rsa -in rsaprivatekey.pem -passin pass:trousers -pubout -out rsapublickey.pem
```

## 生成 RSA 密钥对

如果你已经有了，可以跳过这个部分。

产生1024位RSA私匙，用3DES加密它，口令为trousers，输出到文件rsaprivatekey.pem （这个口令你可以改成你自己的口令，这样安全性更高一点）

```
openssl genrsa -out rsaprivatekey.pem -passout pass:trousers -des3 1024
```

从文件rsaprivatekey.pem读取私匙，用口令trousers解密，生成的公钥匙输出到文件rsapublickey.pem

```
openssl rsa -in rsaprivatekey.pem -passin pass:trousers -pubout -out rsapublickey.pem
```

## Usage

You must exchange public key first.

Name your own private key `rsaprivatekey.pem`.

Name your own public key `rsapublickey.pem`.

Name other people's public key `<name>_rsapublickey.pem`, for example `xiaochi_rsapublickey.pem`.

Edit and save file `letter` and then `send.sh <whom>` to send whom a message.

`fetch.sh` to fetch messages others send to you.

## 使用方法

首先请使用其他手段交换公钥。

并将你自己的私钥命名为 `rsaprivatekey.pem`

将自己的公钥命名为 `rsapublickey.pem`

将别人的公钥命名为 `<名字>_rsapublickey.pem`, 比如 `xiaochi_rsapublickey.pem`

并且打开 `send.sh` 和 `fetch.sh` 文件将开头的配置修改成自己的名字

发送信息：

编辑 `letter` 文件 并 `send.sh <那人的名字>`

接收信息：

`fetch.sh`

## Server

I already build a server.

If you'd like to build your own server, just serve the `server.php` and ensure `DATA_DIR` is writable.

## 构建服务器

已经为您构建好。

如果想运行自己的独立服务器，请直接服务 `server.php` 文件。并且确保 `DATA_DIR` 可写。
