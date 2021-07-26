<template>
  <v-container>
    <v-row justify="center">
      <v-col cols="10">
        <v-card tile>
          <v-container>
            <div>
              <v-card-title>
                <v-icon>
                  mdi-guy-fawkes-mask
                </v-icon>
                CODE CRAFTとは
              </v-card-title>
              <v-divider />
              <v-card-text>
                <p>最新の技術や開発ツールをレビューし関連する勉強会やイベントを催すことで、エンジニア同士の交流を行うことのできるメディアアプリです</p>
              </v-card-text>
              <v-card-title>
                機能
              </v-card-title>
              <v-divider />
              <v-card-text>
                <ul style="font-size: 16px;">
                  <li>ログイン/ゲストログイン</li>
                  <li>会員登録</li>
                  <li>管理者機能</li>
                  <li>ユーザー登録・編集・退会</li>
                  <li>ユーザー間のフォロー</li>
                  <li>レビュー記事投稿</li>
                  <li>投稿へのいいね/コメント</li>
                  <li>レビュー記事に関連するイベント・勉強会の作成/編集</li>
                  <li>イベント参加</li>
                  <li>イベント参加者限定の掲示板</li>
                  <li>ユーザー・投稿・イベントに紐付くタグ</li>
                  <li>ユーザー・投稿・イベント・タグの検索</li>
                </ul>
              </v-card-text>
              <v-card-title>
                使用方法
              </v-card-title>
              <v-divider />
              <v-card-title>
                <span class="pl-2 title">ログイン・会員登録</span>
              </v-card-title>
              <v-card-text>
                <p>右上の[ログイン]を押して、[ゲストユーザーでログイン]を押すと、ログインが完了して右上にプロフィールアイコンが表示されます。</p>
                <v-img
                  src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/321060/3542f91a-208b-0d78-bcbe-ab5556496ab7.gif"
                />
              </v-card-text>
              <v-card-text>
                <p>会員登録では、VeeValidateを用いて、必要事項を満たした入力がされた場合のみユーザーが登録できるようになっています。</p>
                <v-img
                  src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/321060/d9574010-4fa6-e6aa-8ec6-b7d6a850d070.gif"
                />
              </v-card-text>
              <v-card-title>
                <span class="pl-2 title">検索</span>
              </v-card-title>
              <v-card-text>
                <p>
                  メニューの[
                  <v-icon size="15">
                    mdi-magnify
                  </v-icon>
                  検索]を押してください。ユーザー・レビュー記事・イベント・タグの検索ができます。
                </p>
                <v-img
                  src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/321060/ec0bf6c4-3918-e3f7-16b9-9ceb94403a33.gif"
                />
              </v-card-text>
              <v-card-title>
                <span class="pl-2 title">プロフィール編集</span>
              </v-card-title>
              <v-card-text>
                <p>
                  メニューの[
                  <v-icon size="15">
                    mdi-logout-variant
                  </v-icon>
                  プロフィール編集]を押してください。プロフィールの編集では、ユーザー情報の編集、パスワードの変更ができます。
                </p>
                <v-img
                  src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/321060/ae86e2dd-d438-b527-adee-c0f64ff9bc8f.gif"
                />
              </v-card-text>
              <v-card-title>
                <span class="pl-2 title">プロフィール詳細</span>
              </v-card-title>
              <v-card-text>
                <p>
                  プロフィールアイコンを押してメニューの[
                  <v-icon size="15">
                    mdi-account
                  </v-icon>
                  プロフィール詳細]を押してください。プロフィールの詳細、レビュー投稿記事、主催イベント、参加イベントを閲覧することができます。
                </p>
                <v-img
                  src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/321060/99ed557d-2b27-4405-5658-89e5934339bd.gif"
                />
              </v-card-text>
              <v-card-text>
                <p>1.円グラフでは、投稿記事・お気に入り記事・イベント・参加イベントにあるタグの数を集計して、ユーザーの技術傾向を表示しています。</p>
                <p>2.プロフィール詳細内にあるタグを押してみましょう。タグの詳細が表示されて、タグに紐づけられた記事やイベントが表示されます。また、タグのフォローをすることができます。</p>
                <v-img
                  src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/321060/36952e7f-d1c5-b5c5-5ba1-36c3dbecaac8.gif"
                />
              </v-card-text>
              <v-card-text>
                <p>投稿レビューを押すと、ユーザーが作成した投稿一覧を確認することができます。構成は以下の通りです。</p>
                <v-img
                  src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/321060/9ab16647-14fc-d923-0f16-27f4130e70e8.png"
                />
              </v-card-text>
              <v-card-text>
                <p>お気に入りレビューを押すと、ユーザーがいいねした投稿一覧を確認することができます。</p>
                <v-img
                  src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/321060/3ff4297d-a646-6fde-cad0-f0f2efb0cfe3.png"
                />
              </v-card-text>
              <v-card-text>
                <p>投稿詳細ではマークダウンを用いて記事を書いたり、記事へのコメントの投稿もできます。</p>
                <p>(1)</p>
                <v-img
                  src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/321060/a68c2722-4657-f970-b9b9-648d90e99fb4.png"
                />
                <p>(2)</p>
                <v-img
                  src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/321060/7cdc3879-1379-a857-757b-56742c063444.png"
                />
              </v-card-text>
              <v-card-title>
                <span class="pl-2 title">イベントの閲覧・編集</span>
              </v-card-title>
              <v-card-text>
                <p>イベント一覧では、主催イベントの詳細の閲覧・編集を行うことができます。</p>
                <v-img
                  src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/321060/6359fb21-d2d0-2c70-2ffc-f8b0d6786e88.gif"
                />
              </v-card-text>
              <v-card-text>
                <p>イベントの詳細では、参加者の確認・掲示板でのメッセージのやりとり・イベントのキャンセル(主催者以外)ができます。</p>
                <v-img
                  src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/321060/f48b8331-9644-aa6b-cfbe-e5a7212d5751.gif"
                />
              </v-card-text>
              <v-card-text>
                <p>参加イベント一覧では、他ユーザーが主催しているイベントの参加リストを確認することができます。</p>
                <v-img
                  src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/321060/979ea2ab-96a0-16c7-ad6a-d2698a080b19.png"
                />
              </v-card-text>
            </div>
          </v-container>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<style scope>
.title {
  border-left: solid 4px #AEEA00;
}
</style>
