# Hugo Dev Container

## リポジトリについて
Hugoと開発コンテナを使ってポートフォリオを作成するための環境です。

## 前提条件
* Docker(Community Edition)とDocker Composeがインストールされていること
    * [Supported platforms](https://docs.docker.com/engine/install/#server)
    * [Install Docker Engine on Debian](https://docs.docker.com/engine/install/debian/#install-using-the-convenience-script)
    * [Install Docker Engine on Ubuntu](https://docs.docker.com/engine/install/ubuntu/#install-using-the-convenience-script)
* Dockerがルートレスモードで動作していること
    * [Run the Docker daemon as a non-root user (Rootless mode)](https://docs.docker.com/engine/security/rootless/)
* VSCodeと拡張機能がインストールされていること
    * [Remote Development](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack)

## 環境構築
1. リポジトリをクローンする
    <pre>
    $ git clone https://rm.zetsubo.net/ze/hugo-dev-container.git --recurse-submodules
    </pre>
2. build_container_image.shを実行する
    <pre>
    $ cd hugo-dev-container
    $ bash ./script/build_container_image.sh
    </pre>
3. clone_hugo_project.shを実行する
    <pre>
    $ bash ./hugo/volume/usr/local/share/hugo_workspace/clone_hugo_project.sh
    </pre>
4. 開発コンテナを起動する
    1. F1→"Dev Containers: Open Folder in Container..."→hugoを選択してOK
        ![Dev Container](./image/dev_container.png)
        開発コンテナが起動できたら成功
    2. 開発コンテナでターミナルを開き、run_hugo_server.shを実行
        <pre>
        $ bash ./zetsubo-engineer/script/run_hugo_server.sh
        </pre>
        ![run_hugo_server](./image/run_hugo_server.png)
        ![port_forward](./image/port_forward.png)
        自動的に開発コンテナの1313番ポートがフォワードされる
    3. ブラウザで[http://127.0.0.1:1313](http://127.0.0.1:1313)にアクセス
        ![http://127.0.0.1:1313](./image/portfolio.png)
        ポートフォリオが表示されたら成功

## 備考
hugo/volume/usr/local/share/hugo_workspace配下に他のHugoプロジェクトをcloneして開発コンテナを起動できます。  
その場合はhugo/volume/usr/local/share/hugo_workspace/clone_hugo_project.shのHUGO_PROJECT_GIT_URLとHUGO_PROJECT_GIT_BRANCHを適宜変更してください。

## 参考情報
* https://gohugo.io/
* https://code.visualstudio.com/docs/devcontainers/containers