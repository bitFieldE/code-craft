export default ({ $auth, store, route, redirect }) => {
  if (!$auth.isAuthenticated() && (route.name !== 'login' || route.name !== 'signup')) {
    store.dispatch(
      'flash/showMessage',
      {
        message: 'ログインしてください',
        color: 'error',
        status: true
      },
      { root: true }
    )
    return redirect('/login')
  } else if (!$auth.isUserPresent()) {
    // 有効期限内でユーザーが存在しない場合
    return $auth.unauthError()
  } else {
    return redirect('/')
  }
}
