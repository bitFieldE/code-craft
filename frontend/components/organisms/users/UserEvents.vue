<template>
  <v-container>
    <v-row>
      <v-col
        v-for="event in displayEvents"
        :key="event.id"
        cols="12"
        xs="12"
        sm="4"
        md="4"
      >
        <v-card class="mb-8">
          <v-img src="/images/no_img.png">
            <EventModal
              :event="event"
            />
          </v-img>
          {{ $moment(event.scheduled_date).format('YYYY/MM/DD') }}
          <v-card-text class="py-0">
            <v-chip-group
              v-if="event.post.tags.length > 0"
              class="w-100"
              active-class="primary--text"
              column
            >
              <v-chip
                v-for="tag in event.post.tags"
                :key="tag.id"
                color="teal accent-2"
                outlined
                small
              >
                {{ tag.name }}
              </v-chip>
            </v-chip-group>
          </v-card-text>
        </v-card>
      </v-col>
    </v-row>
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
import EventModal from '~/components/molecles/events/EventModal'

export default {
  components: {
    EventModal
  },
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
