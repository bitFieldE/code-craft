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
    <v-row v-if="tags.length > 0">
      <v-col
        v-for="tag in tags"
        :key="tag.id"
      >
        {{ tag.name }}
      </v-col>
    </v-row>
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
      keyword: '',
      tags: []
    }
  },
  methods: {
    async searchTags () {
      await this.$axios.get('api/v1/search/tags', {
        params: {
          keyword: this.keyword
        }
      }).then((response) => {
        this.tags = response.data
        console.log(response)
      })
        .catch((error) => {
          return error
        })
    }
  }
}
</script>
