export const state = () => ({
  user: {},
  followings: [],
  followers: []
})

export const getters = {
  user: state => state.user,
  followings: state => state.followings,
  followers: state => state.followers
}

export const mutations = {
  setUser (state, user) {
    state.user = user
  },
  setFollowings (state, followings) {
    state.followings = followings
  },
  setFollowers (state, followers) {
    state.followers = followers
  }
}
