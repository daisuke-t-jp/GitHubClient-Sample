[English](https://github.com/daisuke-t-jp/GitHubClient-Sample/blob/master/README.md)

# GitHubClient-Sample

<img src="https://raw.githubusercontent.com/daisuke-t-jp/GitHubClient-Sample/master/demo.gif" width="300px">

[GitHub REST API](https://docs.github.com/ja/rest) クライアントの iOS サンプルです。

## 機能

- ユーザを検索
- ユーザ詳細を表示
- ユーザのリポジトリのリンクを開く


## セットアップ方法

### 1. GitHub API のアクセストークンを用意

https://docs.github.com/ja/rest/guides/getting-started-with-the-rest-api#authentication


### 2. mac に CocoaPods-keys をインストール

プロジェクトにアクセストークンを設定するために [CocoaPods-keys](https://github.com/orta/cocoapods-keys) をインストールします。

```zsh
% gem install cocoapods-keys
```


### 3. CocoaPods でライブラリをインストール

プロジェクトのルートで `pod install` を実行します。

コマンド実行後に、以下のように GitHub のアクセストークンが要求されるため、入力してください。

```zsh
% pod install

 CocoaPods-Keys has detected a keys mismatch for your setup.
 What is the key for GitHubPersonalAccessToken
 > 
 ```
 
 
### 4. 実行
 
`GitHubClient-Sample.xcworkspace` を Xcode で開いて実行できます。

