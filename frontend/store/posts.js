export const state = () => ({
  post: {},
  posts: [],
  likedPosts: []
})

export const getters = {
  post: state => state.post,
  posts: state => state.posts,
  likedPosts: state => state.likedPosts
}

export const mutations = {
  setPost (state, post) {
    state.post = post
  },
  setPosts (state, posts) {
    state.posts = posts
  },
  deletePost (state, postId) {
    state.posts = state.posts.filter(post => post.id !== postId)
  },
  setLikedPosts (state, likedPosts) {
    state.likedPosts = likedPosts
  },
  deleteLikedPost (state, likedPostId) {
    state.likedPosts = state.likedPosts.filter(likedPost => likedPost.id !== likedPostId)
  }
}
