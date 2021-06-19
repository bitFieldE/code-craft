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
