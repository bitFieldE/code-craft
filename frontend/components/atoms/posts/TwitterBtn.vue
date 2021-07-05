<template>
  <v-btn
    class="white--text"
    color="#26c6da"
    :href="twitterUrl"
  >
    <v-icon
      left
    >
      mdi-twitter
    </v-icon>
    Twitterでシェア
  </v-btn>
</template>

<script>
export default {
  props: {
    post: {
      type: Object,
      default: null
    }
  },
  computed: {
    twitterUrl () {
      return `http://twitter.com/share?url=http://localhost:8080${this.$route.path}&text=${this.post.title}`
    }
  }
}
</script>
