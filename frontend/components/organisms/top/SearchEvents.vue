<template>
  <v-container>
    <v-card-title>
      イベント
    </v-card-title>
    <TextFieldWithValidation
      v-model="keyword"
      prepend-icon="mdi-magnify"
      @keyup="searchEvents"
    />
    <SearchEventsTemplate
      v-if="events.length > 0"
      :events="events"
      :loading="loading"
    />
  </v-container>
</template>

<script>
import TextFieldWithValidation from '~/components/atoms/input/TextFieldWithValidation'
import SearchEventsTemplate from '~/components/molecles/SearchEventsTemplate'

export default {
  components: {
    TextFieldWithValidation,
    SearchEventsTemplate
  },
  data () {
    return {
      keyword: '',
      events: [],
      loading: null
    }
  },
  methods: {
    async searchEvents () {
      this.loading = true
      await this.$axios.get('api/v1/search/events', {
        params: {
          keyword: this.keyword
        }
      }).then((response) => {
        this.events = response.data
      })
        .catch((error) => {
          return error
        })
      this.loading = false
    }
  }
}
</script>
