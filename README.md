# stable diffusionをDockerを使い環境を問わず簡単に構築する方法

以下のコマンドでwebuiであるautomatic1111を構築できます。

```ssh
make clone
```

automatic1111clone後にdockerを立ち上げるとstable diffusionが使えるようになります。

```ssh
docker compose up --build
```

立ち上がった後に以下のURLにアクセスしてください。

http://localhost:7860/
