<template>
  <div v-if="$auth.loggedIn && user.id !== $auth.user.id">
    <v-btn
      v-if="is_followed"
      class="ml-3"
      color="info"
      rounded
      small
      @click="unFollowUser"
    >
      <v-icon left>
        mdi-minus
      </v-icon>
      アンフォロー
    </v-btn>
    <v-btn
      v-else
      class="ml-3"
      color="warning"
      rounded
      small
      @click="followUser"
    >
      <v-icon left>
        mdi-plus
      </v-icon>
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
    },
    followers: {
      type: Array,
      default: () => []
    }
  },
  data () {
    return {
      is_followed: false
    }
  },
  mounted () {
    if (this.followers.find(v => v.id === this.$auth.user.id)) { this.is_followed = true }
  },
  methods: {
    async followUser () {
      const formData = new FormData()
      formData.append('user_id', this.$auth.user.id)
      formData.append('follow_id', this.user.id)
      await this.$axios.$post('/api/v1/relationships', formData)
        .then(
          (response) => {
            this.is_followed = true
            if (Number(this.$route.params.id) === response.user.id) {
              this.$store.commit('user/setFollowers', response.user.followers, { root: true })
            }
            this.$store.dispatch(
              'flash/showMessage',
              {
                message: response.message,
                color: 'warning',
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
      await this.$axios.$delete(`/api/v1/relationships/${this.user.id}`, { data: { user_id: this.$auth.user.id } })
        .then(
          (response) => {
            this.is_followed = false
            if (Number(this.$route.params.id) === response.user.id) {
              this.$store.commit('user/setFollowers', response.user.followers, { root: true })
            }
            this.$store.dispatch(
              'flash/showMessage',
              {
                message: response.message,
                color: 'info',
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
