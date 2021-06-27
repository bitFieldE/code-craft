export default function ({ $auth, store, redirect }) {
  if (!$auth.loggedIn) {
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
  }
}
