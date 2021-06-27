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
  },
  deleteComment (state, commentId) {
    state.comments = state.comments.filter(comment => comment.id !== commentId)
  }
}
