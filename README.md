# crypto-letter

# 密信

## Usage

You must exchange public key first.

Name your own private key `rsaprivatekey.pem`.

Name your own public key `rsapublickey.pem`.

Name other people's public key `<name>_rsapublickey.pem`, for example `xiaochi_rsapublickey.pem`.

edit and save file `letter` and then `send.sh <whom>` to send whom a message.

`fetch.sh` to fetch messages others send to you.

## 使用方法

首先请使用其他手段交换公钥。

并将你自己的私钥命名为 `rsaprivatekey.pem`

将自己的公钥命名为 `rsapublickey.pem`

将别人的公钥命名为 `<名字>_rsapublickey.pem`, 比如 `xiaochi_rsapublickey.pem`

发送信息：

编辑 `letter` 文件 并 `send.sh <那人的名字>`

接收信息：

`fetch.sh`

## Server

I already build a server.

if you like build your own server, just serve the `server.php` and ensure `DATA_DIR` is writable.

## 构建服务器

已经为您构建好。

如果想运行自己的独立服务器，请直接服务 `server.php` 文件。并且确保 `DATA_DIR` 可写。
