<template>
  <v-container>
    <v-card-title>
      タグ
    </v-card-title>
    <TextFieldWithValidation
      v-model="keyword"
      prepend-icon="mdi-magnify"
      @keyup="searchTags"
    />
    <SearchTagsTemplate
      v-if="tags.length > 0"
      :tags="tags"
      :loading="loading"
    />
  </v-container>
</template>

<script>
import TextFieldWithValidation from '~/components/atoms/input/TextFieldWithValidation'
import SearchTagsTemplate from '~/components/molecles/SearchTagsTemplate'

export default {
  components: {
    TextFieldWithValidation,
    SearchTagsTemplate
  },
  data () {
    return {
      keyword: '',
      tags: [],
      loading: null
    }
  },
  methods: {
    async searchTags () {
      this.loading = true
      await this.$axios.get('api/v1/search/tags', {
        params: {
          keyword: this.keyword
        }
      }).then((response) => {
        this.tags = response.data
      })
        .catch((error) => {
          return error
        })
      this.loading = false
    }
  }
}
</script>
