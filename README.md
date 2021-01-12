#table構造
***
- Users
  - name :string
  - password_digest :string
***
- Tasks
  - name :string
  - contents :text
  - state :string
  - dead_line :datetime
  - user_id :inetger
***
- Labels
  - user_id :integer
  - task_id :integer
  - label_id :integer
***

#herokuへのupload方法
***
1.herokuのログイン
```
heroku login --interactive
```

2.herokuのアプリ作成
```
heroku create
```

3.プリコンパイルの実行
```
rails assets:precompile
```

4.gitコマンドで変更分の登録・プルリクエストの作成
```
git add .
git commit -m "作成した機能についての説明"
git push origin 作業中のブランチ
```

5.herokuへのデプロイ
```
git push heroku 作業中のディレクトリ
git run rails db:migrate
```
***