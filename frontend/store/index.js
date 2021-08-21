export const state = () => ({
  loggedIn: false,
  current: {
    user: null
  }
})

export const mutations = {
  setLoggedIn (state, payload) {
    state.loggedIn = payload
  },
  setCurrentUser (state, payload) {
    state.current.user = payload
  }
}

export const actions = {
  nuxtClientInit ({ commit }) {
    if (localStorage.getItem('vuex')) {
      const data = JSON.parse(localStorage.getItem('vuex')) || []
      console.log(data.current.user)
      if (data.current.user != null) {
        commit('setCurrentUser', data.current.user)
      }
    }
  },
  login ({ commit }) {
    commit('setLoggedIn', true)
  },
  logout ({ commit }) {
    commit('setLoggedIn', false)
  },
  getCurrentUser ({ commit }, user) {
    commit('setCurrentUser', user)
  }
}
