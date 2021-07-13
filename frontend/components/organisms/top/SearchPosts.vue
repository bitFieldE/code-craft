<template>
  <v-container>
    <v-card-title>
      投稿
    </v-card-title>
    <TextFieldWithValidation
      v-model="keyword"
      prepend-icon="mdi-magnify"
      @keyup="searchPosts"
    />
  </v-container>
</template>

<script>
import TextFieldWithValidation from '~/components/atoms/input/TextFieldWithValidation'

export default {
  components: {
    TextFieldWithValidation
  },
  data () {
    return {
      keyword: ''
    }
  },
  methods: {
    async searchPosts () {
      await this.$axios.get('api/v1/search/posts', {
        params: {
          keyword: this.keyword
        }
      }).then((response) => {
        console.log(response)
      })
        .catch((error) => {
          return error
        })
    }
  }
}
</script>
