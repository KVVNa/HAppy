# HAppy — 18時の味方

朝の準備から、仕事終わりのご褒美まで。スマホとPCで使うデイリープランナーです。

**アプリ：https://kvvna.github.io/HAppy/**

## できること

- 起床・出発・仕事・帰宅のタイムライン
- ひとつずつ進める朝の準備、今日の大事な3つ
- 集中タイマー、ご褒美、できたことが花になる庭
- 明日の最初の一手と未完了メモ、翌仕事日への引き継ぎ
- 自動保存、Supabaseでログインしてスマホ・PC同期

初期設定は起床06:20、出発07:05、始業07:50、退勤18:00です。時間・朝の準備は変更できます。
Supabase未設定でも、端末内保存で使えます。集中タイマーは各端末で動作します。

## スマホ・PC同期を有効にする

1. [Supabase](https://supabase.com/dashboard)でアカウントと新規プロジェクトを作ります。
2. SQL Editorで、このリポジトリの[setup.sql](setup.sql)を全文実行します。
3. Authentication → URL ConfigurationのSite URLとRedirect URLsに `https://kvvna.github.io/HAppy/` を設定します。
4. プロジェクト設定でProject URLとPublishable keyを取得します。
5. アプリの「初回の接続設定」に両方を入力します。スマホ・PCに同じ情報を設定します。
6. 同じメールアドレスでログインし、メールのリンクをログインしたい端末で開きます。

Secret key、service_roleキー、DBパスワードは使いません。個人のメモはGitHubへアップロードしません。SQLのアクセス制御で、ログインした本人だけがデータを読み書きできます。

Supabaseの標準メール送信には宛先制限があります。最初はSupabaseのアカウントと同じメールを使ってください。ほかの宛先には[Custom SMTP](https://supabase.com/docs/guides/auth/auth-smtp)の設定が必要になる場合があります。

## 公開構成と開発

このリポジトリのルートにはビルド済みアプリを置いています。GitHub Pagesは **Deploy from a branch / main / (root)** を使用します。

[HAppy-source.zip](HAppy-source.zip)に、編集用ソース、14件の自動テスト、ビルドスクリプト、GitHub Actions用の設定、詳しいセットアップ説明をまとめています。解凍後、Node.js 22以上で `npm ci`、`npm test`、`npm run build` を実行します。生成されたdist内の6ファイルをルートに反映してください。

同期処理はローカルテスト済みです。実際のメール・2端末同期はSupabase接続後に確認してください。同じ項目を両端末で変えると、残したい内容を選べます。別の項目は自動で統合します。

旧HTMLのデータは「記録を書き出す」→新版の「記録ファイルを取り込む」で移せます。

参考：[Structured](https://structured.app/) / [Finch](https://finchcare.com/) / [Todoist](https://www.todoist.com/templates/work-shutdown-ritual)
