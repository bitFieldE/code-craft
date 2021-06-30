<template>
  <v-container>
    <v-card
      v-for="event in displayEvents"
      :key="event.id"
      class="mb-8"
    >
      <v-img src="/images/no_img.png"></v-img>
      {{ event }}
      {{ event.post.tags }}
    </v-card>
    <v-card-text>
      <v-pagination
        v-model="page"
        color="info"
        :length="EventsLength"
        @input="pageChange"
      />
    </v-card-text>
  </v-container>
</template>

<script>
export default {
  props: {
    events: {
      type: Array,
      default: () => []
    }
  },
  data () {
    return {
      page: 1,
      length: 0,
      pageSize: 5
    }
  },
  computed: {
    displayEvents () {
      return this.events.slice(this.pageSize * (this.page - 1), this.pageSize * (this.page))
    },
    EventsLength () {
      return Math.ceil(this.events.length / this.pageSize)
    }
  },
  methods: {
    pageChange (pageNumber) {
      this.displayEvents.slice(this.pageSize * (pageNumber - 1), this.pageSize * (pageNumber))
    }
  }
}
</script>
