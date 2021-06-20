export const state = () => ({
  comments: []
})

export const getters = {
  comments: state => state.comments
}

export const mutations = {
  setComments (state, comments) {
    state.comments = comments
  }
}
