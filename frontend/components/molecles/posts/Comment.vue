<template>
  <v-card>
    <v-container>
      <v-card-actions>
        <v-avatar color="black" size="40" class="mr-1">
          <v-img
            v-if="comment.user.image_url"
            :src="comment.user.image_url"
          />
          <v-icon
            v-else
            color="white"
            size="40"
          >
            mdi-account-circle
          </v-icon>
        </v-avatar>
        <span class="pl-2">
          {{ comment.user.name }}
        </span>
      </v-card-actions>
      <v-card-text v-html="$md.render(comment.content)" />
      <v-card-subtitle class="pb-0">
        {{ comment.created_date }}
        <v-btn
          v-if="comment.user.id == $auth.user.id"
          icon
        >
          <v-icon
            size="20"
            @click="deleteComment(comment.id)"
          >
            mdi-trash-can-outline
          </v-icon>
        </v-btn>
      </v-card-subtitle>
    </v-container>
  </v-card>
</template>

<script>
export default {
  props: {
    comment: {
      type: Object,
      default: () => {}
    }
  },
  methods: {
    async deleteComment (commentId) {
      await this.$axios.$delete(`/api/v1/comments/${commentId}`)
        .then(
          (response) => {
            this.$store.commit('comments/deleteComment', commentId, { root: true })
          },
          (error) => {
            return error
          }
        )
    }
  }
}
</script>
