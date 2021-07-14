<template>
  <v-container>
    <v-card-title>
      ユーザー
    </v-card-title>
    <TextFieldWithValidation
      v-model="keyword"
      prepend-icon="mdi-magnify"
      @keyup="searchUsers"
    />
    <SearchUsersTemplate
      v-if="users.length > 0"
      :users="users"
      :loading="loading"
    />
  </v-container>
</template>

<script>
import TextFieldWithValidation from '~/components/atoms/input/TextFieldWithValidation'
import SearchUsersTemplate from '~/components/molecles/SearchUsersTemplate'

export default {
  components: {
    TextFieldWithValidation,
    SearchUsersTemplate
  },
  data () {
    return {
      keyword: '',
      users: [],
      loading: null
    }
  },
  methods: {
    async searchUsers () {
      this.loading = true
      await this.$axios.get('api/v1/search/users', {
        params: {
          keyword: this.keyword
        }
      }).then((response) => {
        this.users = response.data
        console.log(response)
      })
        .catch((error) => {
          return error
        })
      this.loading = false
    }
  }
}
</script>
