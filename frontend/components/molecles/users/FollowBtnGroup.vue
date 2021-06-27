<template>
  <div v-if="$auth.loggedIn && user.id !== $auth.user.id">
    <v-btn
      v-if="is_followed"
      class="ml-3"
      color="info"
      rounded
      @click="unFollowUser"
    >
      アンフォロー
    </v-btn>
    <v-btn
      v-else
      class="ml-3"
      color="warning"
      rounded
      @click="followUser"
    >
      フォロー
    </v-btn>
  </div>
</template>

<script>
export default {
  props: {
    user: {
      type: Object,
      default: () => {}
    }
  },
  data () {
    return {
      is_followed: false
    }
  },
  mounted () {
    if (this.user.followers.find(v => v.id === this.$auth.user.id)) { this.is_followed = true }
  },
  methods: {
    async followUser () {
      const formData = new FormData()
      formData.append('follow_id', this.user.id)
      await this.$axios.$post('/api/v1/relationships', formData)
        .then(
          (response) => {
            this.is_followed = true
            this.$store.commit('user/setUser', response.user, { root: true })
            this.$store.dispatch(
              'flash/showMessage',
              {
                message: response.message,
                color: 'success',
                status: true
              },
              { root: true }
            )
          },
          (error) => {
            this.$store.dispatch(
              'flash/showMessage',
              {
                message: error,
                color: 'error',
                status: true
              },
              { root: true }
            )
            return error
          }
        )
    },
    async unFollowUser () {
      await this.$axios.$delete(`/api/v1/relationships/${this.user.id}`)
        .then(
          (response) => {
            this.is_followed = false
            this.$store.commit('user/setUser', response.user, { root: true })
            this.$store.dispatch(
              'flash/showMessage',
              {
                message: response.message,
                color: 'success',
                status: true
              },
              { root: true }
            )
          },
          (error) => {
            this.$store.dispatch(
              'flash/showMessage',
              {
                message: error,
                color: 'error',
                status: true
              },
              { root: true }
            )
            return error
          }
        )
    }
  }
}
</script>
