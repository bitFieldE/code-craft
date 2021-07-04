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
            <v-card-text>
              <EventModal
                :event="event"
              />
            </v-card-text>
          </v-img>
          <v-card-title class="text-h5">
            {{ event.title }}
          </v-card-title>
          <v-card-subtitle>
            {{ $moment(event.scheduled_date).format('YYYY/MM/DD') }}
          </v-card-subtitle>
          <v-card-text>
            <v-chip-group
              v-if="event.post.tags.length > 0"
              class="w-100"
              active-class="primary--text"
              column
            >
              <v-chip
                v-for="tag in event.post.tags"
                :key="tag.id"
                color="info"
                class="white--text ml-0"
                small
              >
                {{ tag.name }}
              </v-chip>
            </v-chip-group>
          </v-card-text>
          <v-card-text class="pt-0">
            <v-btn
              class="pt-0"
              color="pink accent-2"
              @click="cancelEvent(event.id)"
            >
              <v-icon>
                mdi-trash-can-outline
              </v-icon>
              参加をキャンセルする
            </v-btn>
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
    },
    async cancelEvent (eventId) {
      if (window.confirm('削除してもよろしいですか？')) {
        await this.$axios.$delete(`/api/v1/join_events/${eventId}`)
          .then(
            (response) => {
              this.$store.commit('events/deleteEvent', eventId, { root: true })
              this.$store.dispatch(
                'flash/showMessage',
                {
                  message: response.message,
                  color: 'primary',
                  status: true
                },
                { root: true }
              )
            },
            (error) => {
              this.$store.dispatch(
                'flash/showMessage',
                {
                  message: error,
                  color: 'error',
                  status: true
                },
                { root: true }
              )
              return error
            }
          )
      }
    }
  }
}
</script>
