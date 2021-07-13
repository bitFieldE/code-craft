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
    <v-row v-if="events.length > 0">
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
      events: []
    }
  },
  methods: {
    async searchEvents () {
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
    }
  }
}
</script>
