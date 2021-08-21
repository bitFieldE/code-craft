class Authentication {
  constructor (ctx) {
    this.store = ctx.store
    this.$axios = ctx.$axios
    this.error = ctx.error
    this.$config = ctx.$config
  }

  // Vuexのユーザーを返す
  get user () {
    return this.store.state.current.user || {}
  }

  // ユーザーオブジェクトがある場合にtrueを返す
  isUserPresent () {
    return ('id' in this.user)
  }

  // 有効期限内、かつユーザーが存在する場合にtrueを返す
  get loggedIn () {
    return this.isUserPresent()
  }

  // ログイン処理
  login (user) {
    this.store.dispatch('getCurrentUser', user)
    this.store.dispatch('login')
  }

  // ログアウト処理
  logout () {
    this.$axios.$delete('/api/v1/auth/sign_out')
    this.store.dispatch('getCurrentUser', null)
    this.store.dispatch('logout')
  }
}

export default ({ store, $axios, error, $config }, inject) => {
  inject('auth', new Authentication({ store, $axios, error, $config }))
}
