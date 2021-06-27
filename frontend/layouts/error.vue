<template>
  <v-app dark>
    <v-container>
      <v-card-title v-if="error.statusCode === 404">
        {{ pageNotFound }}
      </v-card-title>
      <v-card-title v-else>
        {{ otherError }}
      </v-card-title>
      <NuxtLink to="/">
        Home
      </NuxtLink>
    </v-container>
  </v-app>
</template>

<script>
export default {
  layout: 'empty',
  props: {
    error: {
      type: Object,
      default: null
    }
  },
  data () {
    return {
      pageNotFound: '404 ページが見つかりません',
      otherError: 'エラーが発生しました'
    }
  },
  head () {
    const title =
      this.error.statusCode === 404 ? this.pageNotFound : this.otherError
    return {
      title
    }
  }
}
</script>

<style scoped>
h1 {
  font-size: 20px;
}
</style>
