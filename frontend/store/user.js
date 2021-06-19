export const state = () => ({
  user: {}
})

export const getters = {
  user: state => state.user
}

export const mutations = {
  setUser (state, user) {
    state.user = user
  }
}
