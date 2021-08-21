<template>
  <v-card>
    <v-container>
      <v-card-actions>
        <nuxt-link
          :to="{ path: `/users/${comment.user.id}` }"
          style="color: inherit; text-decoration: none;"
        >
          <v-avatar
            v-if="comment.user.image.url"
            color="black"
            size="40"
            class="m-0"
          >
            <v-img
              :src="comment.user.image.url"
            />
          </v-avatar>
          <v-icon
            v-else
            size="40"
          >
            mdi-account-circle
          </v-icon>
          <span class="pl-2">
            {{ comment.user.name }}
          </span>
        </nuxt-link>
      </v-card-actions>
      <v-card-text v-html="$md.render(comment.content)" />
      <v-card-subtitle class="pb-0">
        {{ $moment(comment.created_at).format('YYYY/MM/DD HH:MM') }}
        <v-btn
          v-if="comment.user.id == $auth.user.id"
          icon
        >
          <v-icon
            size="20"
            @click="deleteEventComment(comment.id)"
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
    async deleteEventComment (commentId) {
      await this.$axios.$delete(`/api/v1/event_comments/${commentId}`)
        .then(
          (response) => {
            this.$store.commit('comments/deleteEventComment', commentId, { root: true })
          },
          (error) => {
            return error
          }
        )
    }
  }
}
</script>
