export const state = () => ({
  comments: []
})

export const getters = {
  comments: state => state.comments
}

export const mutations = {
  setComments (state, comments) {
    state.comments = comments
  },
  addComments (state, comment) {
    state.comments.push(comment)
  }
}
