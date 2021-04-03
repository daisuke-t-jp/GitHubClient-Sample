[日本語](https://github.com/daisuke-t-jp/GitHubClient-Sample/blob/master/README.ja.md)

# GitHubClient-Sample

<img src="https://raw.githubusercontent.com/daisuke-t-jp/GitHubClient-Sample/master/demo.gif" width="300px">

[GitHub REST API](https://docs.github.com/en/rest) iOS sample client.

## Features

- Search users.
- View users details.
- Open user's repository link.


## Setup

### 1. Getting GitHub API access token

https://docs.github.com/en/rest/guides/getting-started-with-the-rest-api#authentication


### 2. Install CocoaPods-keys on mac

Install [CocoaPods-keys](https://github.com/orta/cocoapods-keys) for settings access token to project.

```zsh
% gem install cocoapods-keys
```


### 3. Install CocoaPods libraries

Run `pod install` at project root.

When you execute the command, you will be asked for GitHub access token.  And you input this.

```zsh
% pod install

 CocoaPods-Keys has detected a keys mismatch for your setup.
 What is the key for GitHubPersonalAccessToken
 > 
 ```
 
 
### 4. Run
 
Open `GitHubClient-Sample.xcworkspace` and run.

