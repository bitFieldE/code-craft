# CodeCraft
## アプリの詳細
最新の技術や開発ツールをレビューし関連する勉強会やイベントを催すことで、同じような技術を用いるエンジニア同士の交流を行うことを目的としたメディアアプリです。

## 詳細記事
https://qiita.com/bitFieldE/items/31e0c5ee2a092326f014
<br>
<br>
https://codecraftapp.com/
<br>
<br>
今回のアプリで2作品目となります。
<br>
<br>
[前作リポジトリ](https://github.com/RkAirforce/aic_tech)

## 技術
#### フロントエンド

|使用技術|詳細|
|-|-|
|Nuxt.js 2.15.3(SPA mode)|フロントエンドフレームワーク|
|Vuetify|UIコンポーネント|
|Jest|テスト(Vuexに値が保存されているかを確認するテスト)|

#### バックエンド

|使用技術|詳細|
|-|-|
|Rails6.1.3(API)|APIサーバー|
|PostgreSQL13.3|データベース|
|Rspec|request/model テスト|
|Rubocop|コードを解析して、自動でリファクタリング|


#### インフラ周り

|使用技術|詳細|
|-|-|
|ECS(Fargate)|Dockerコンテナ環境を構築|
|RDS|本番環境（PostgreSQL13.3）/画像以外のデータを保存|
|S3|ActiveStorageを用いて画像データをS3バケットに保存|
|Route53|オリジナルドメインを登録する目的|
|ACM(AWS Certificate Manager)|お名前.comからドメインを取得して、Route53で作成されたNSレコードをお名前.comのDNSサーバーに登録|
|SSM(AWS System Manager)|本番環境の環境変数を管理|
|Docker/docker-compose|docker-composeではローカルの開発環境を構築して、DockerはDockerfileを開発/本番環境それぞれ分けて作成|
|Terraform|インフラ環境をコードで管理|

#### ER図
![erd.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/321060/2061b851-441f-24ea-105a-45e8dcd71e0f.png)

#### 全体設計
![Untitled Diagram.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/321060/3d25239a-2e25-e2b2-0c81-d70cbd1945bc.png)