export default function ({ $auth, route, redirect }) {
  if (($auth.loggedIn && route.name === 'login') || ($auth.loggedIn && route.name === 'signup')) {
    return redirect('/')
  }
}
