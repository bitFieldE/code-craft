<template>
  <v-card>
    <v-card-text class="pb-0">
      {{ post.created_date }}
      <AddStudyEvent
        :post="post"
      />
      <v-btn
        v-if="$auth.loggedIn&&post.user_id==$auth.user.id"
        class="float-right mr-2"
        :to="{ path: `/posts/edit/${post.id}` }"
        icon
      >
        <v-icon>
          mdi-square-edit-outline
        </v-icon>
      </v-btn>
    </v-card-text>
    <nuxt-link
      :to="{ path: `/posts/${post.id}` }"
      style="color: inherit; text-decoration: none;"
    >
      <v-card-title class="pb-0" style="font-size: 15px;">
        {{ post.title }}
      </v-card-title>
      <v-card-actions class="ml-2">
        <v-rating
          :value="post.rate"
          color="yellow darken-3"
          background-color="grey darken-1"
          readonly
          half-increments
          dense
          small
        />
        <span class="rate pl-1">
          ( {{ post.rate }} )
        </span>
      </v-card-actions>
    </nuxt-link>
    <v-card-text
      v-if="post.tags"
      class="pt-0"
    >
      <v-chip-group
        active-class="primary--text"
        column
      >
        <v-chip
          v-for="tag in post.tags"
          :key="tag.id"
          color="info"
          outlined
          small
        >
          {{ tag.name }}
        </v-chip>
      </v-chip-group>
    </v-card-text>
  </v-card>
</template>

<script>
import AddStudyEvent from '~/components/molecles/users/AddStudyEvent'

export default {
  components: {
    AddStudyEvent
  },
  props: {
    post: {
      type: Object,
      default: () => {}
    }
  }
}
</script>

<style>
.rate {
  font-size: 12px;
}
</style>
