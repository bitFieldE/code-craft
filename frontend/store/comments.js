export const state = () => ({
  comments: [],
  eventComments: []
})

export const getters = {
  comments: state => state.comments,
  eventComments: state => state.eventComments
}

export const mutations = {
  setComments (state, comments) {
    state.comments = comments
  },
  setEventComments (state, eventComments) {
    state.eventComments = eventComments
  },
  addComments (state, comment) {
    state.comments.push(comment)
  },
  deleteComment (state, commentId) {
    state.comments = state.eventComments.filter(comment => comment.id !== commentId)
  },
  addEventComments (state, eventComment) {
    state.eventComments.push(eventComment)
  },
  deleteEventComment (state, eventCommentId) {
    state.eventComments = state.eventComments.filter(eventComment => eventComment.id !== eventCommentId)
  }
}
