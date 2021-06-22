<template>
  <v-card>
    <v-container>
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
      {{ comment.user.name }}
      <v-card-text v-html="$md.render(comment.content)" />
      <v-card-subtitle class="pb-0">
        {{ comment.created_date }}
        <v-btn
          v-if="comment.user.id == $auth.user.id"
          icon
        >
          <v-icon size="20">
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
  }
}
</script>
