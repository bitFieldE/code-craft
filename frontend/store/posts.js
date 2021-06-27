export const state = () => ({
  posts: [],
  post: {}
})

export const getters = {
  post: state => state.post
}

export const mutations = {
  setPost (state, post) {
    state.post = post
  }
}
