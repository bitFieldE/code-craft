// ログイン状態を維持するclient初期設定ファイル
export default async ({ $auth, $axios, store }) => {
  if ($auth.isAuthenticated()) {
    await $axios.$get('/api/v1/users/current_user')
      .then(authUser => store.dispatch('getCurrentUser', authUser))
      // Cookieはサーバーで削除済み
      .catch(() => $auth.removeStorage())
  }
}
