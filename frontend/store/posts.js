export const state = () => ({
  post: {},
  posts: [],
  famousPosts: [],
  likedPosts: []
})

export const getters = {
  post: state => state.post,
  posts: state => state.posts,
  likedPosts: state => state.likedPosts,
  famousPosts: state => state.famousPosts
}

export const mutations = {
  setPost (state, post) {
    state.post = post
  },
  setPosts (state, posts) {
    state.posts = posts
  },
  setLikedPosts (state, likedPosts) {
    state.likedPosts = likedPosts
  },
  setFamousPosts (state, famousPosts) {
    state.famousPosts = famousPosts
  },
  deletePost (state, postId) {
    state.posts = state.posts.filter(post => post.id !== postId)
  },
  updatePost (state, postData) {
    state.posts = state.posts.map((post) => {
      if (post.id === postData.id) {
        post = postData
      }
      return post
    })
  },
  deleteLikedPost (state, likedPostId) {
    state.likedPosts = state.likedPosts.filter(likedPost => likedPost.id !== likedPostId)
  }
}
