# 美少女散歩

## 起動方法

1. まずは Docker をインストールする

<https://docs.docker.com/engine/install/>

2. gem のインストール

```shell
bundle install
```

3. Dockerfile のビルド

```shell
docker compose build
```

4. 起動してみる

```shell
docker compose watch
```

もしくは

```
docker compose up -d
```

その後ブラウザで`localhost:3000`にアクセス！
