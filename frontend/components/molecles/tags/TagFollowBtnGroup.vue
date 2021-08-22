<template>
  <div>
    <v-btn
      v-if="is_followed"
      color="info"
      rounded
      small
      @click="unFollowTag"
    >
      <v-icon left>
        mdi-minus
      </v-icon>
      アンフォロー
    </v-btn>
    <v-btn
      v-else
      color="warning"
      rounded
      small
      @click="followTag"
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
      formData.append('user_id', this.$auth.user.id)
      await this.$axios.$post('/api/v1/tags', formData)
        .then(
          (response) => {
            this.$store.commit('tags/setTag', response, { root: true })
            this.is_followed = true
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
      await this.$axios.$delete(`/api/v1/tags/${this.tag.id}`, { data: { user_id: this.$auth.user.id } })
        .then(
          (response) => {
            this.is_followed = false
            this.$store.commit('tags/setTag', response, { root: true })
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
