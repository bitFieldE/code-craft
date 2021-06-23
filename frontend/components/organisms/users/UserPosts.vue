<template>
  <v-card>
    <nuxt-link
      :to="{ path: `/posts/${post.id}` }"
      style="color: inherit; text-decoration: none;"
    >
      <v-card-text class="pb-0">
        {{ post.created_date }}
      </v-card-text>
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
          :key="tag"
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
export default {
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
