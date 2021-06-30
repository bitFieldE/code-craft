<template>
  <div>
    <v-btn
      v-if="is_liked"
      icon
      @click="unlikePost"
    >
      <v-icon size="20" color="red">
        mdi-heart
      </v-icon>
    </v-btn>
    <v-btn
      v-else
      icon
      @click="likePost"
    >
      <v-icon size="20" color="red">
        mdi-heart-outline
      </v-icon>
    </v-btn>
  </div>
</template>

<script>
export default {
  props: {
    post: {
      type: Object,
      default: () => {}
    }
  },
  data () {
    return {
      is_liked: false
    }
  },
  mounted () {
    if (this.post.liked_users.find(v => v.id === this.$auth.user.id)) { this.is_liked = true }
  },
  methods: {
    async likePost () {
      const formData = new FormData()
      formData.append('like[post_id]', this.post.id)
      await this.$axios.$post('/api/v1/likes', formData)
        .then(
          (response) => {
            this.is_liked = true
            return response
          },
          (error) => {
            return error
          }
        )
    },
    async unlikePost () {
      await this.$axios.$delete(`/api/v1/likes/${this.post.id}`)
        .then(
          (response) => {
            this.is_liked = false
            return response
          },
          (error) => {
            return error
          }
        )
    }
  }
}
</script>
