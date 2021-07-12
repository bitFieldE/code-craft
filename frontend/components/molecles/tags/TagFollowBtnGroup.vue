<template>
  <div>
    <v-btn
      v-if="is_followed"
      class="ml-3"
      color=""
      rounded
      small
      @click="unFollowTag"
    >
      アンフォロー
    </v-btn>
    <v-btn
      v-else
      class="ml-3"
      color="warning"
      rounded
      small
      @click="followTag"
    >
      フォロー
    </v-btn>
  </div>
</template>

<script>
export default {
  props: {
    tag: {
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
    if (this.tag.users.find(v => v.id === this.$auth.user.id)) { this.is_followed = true }
  },
  methods: {
    async followTag () {
      const formData = new FormData()
      formData.append('id', this.tag.id)
      await this.$axios.$post('/api/v1/tags', formData)
        .then(
          (response) => {
            this.$store.commit('tags/setTag', response, { root: true })
            this.is_followed = true
            this.$store.dispatch(
              'flash/showMessage',
              {
                message: response,
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
    async unFollowTag () {
      await this.$axios.$delete(`/api/v1/tags/${this.tag.id}`)
        .then(
          (response) => {
            this.is_followed = false
            this.$store.commit('tags/setTag', response, { root: true })
            this.$store.dispatch(
              'flash/showMessage',
              {
                message: response,
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
