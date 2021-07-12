<template>
  <v-container>
    <v-row v-if="loading">
      <v-col
        v-for="n in 6"
        :key="n"
        cols="12"
        xs="12"
        sm="4"
        md="4"
      >
        <v-skeleton-loader
          type="card"
        />
      </v-col>
    </v-row>
    <v-row v-else>
      <v-col
        v-for="(joinedEvent, index) in displayJoinedEvents"
        :key="index"
        cols="12"
        xs="12"
        sm="4"
        md="4"
      >
        <v-card class="mb-8">
          <v-img src="/images/no_img.png">
            <v-row no-gutters>
              <v-col cols="12">
                <div class="float-right mt-2 mr-2">
                  <EventModal
                    :event="joinedEvent"
                  />
                </div>
              </v-col>
            </v-row>
          </v-img>
          <v-card-title class="text-h5">
            {{ joinedEvent.title }}
          </v-card-title>
          <v-card-subtitle>
            {{ $moment(joinedEvent.scheduled_date).format('YYYY/MM/DD') }}
          </v-card-subtitle>
          <v-card-text class="pt-0">
            <v-btn
              v-if="$auth.user.id==user.id"
              class="pt-0 white--text"
              color="pink accent-2"
              @click="cancelEvent(joinedEvent)"
            >
              <v-icon>
                mdi-trash-can-outline
              </v-icon>
            </v-btn>
          </v-card-text>
        </v-card>
      </v-col>
    </v-row>
    <v-card-text>
      <v-pagination
        v-model="page"
        color="info"
        :length="joinedEventsLength"
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
    user: {
      type: Object,
      default: () => {}
    },
    joinedEvents: {
      type: Array,
      default: () => []
    },
    loading: {
      type: Boolean,
      default: null
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
    displayJoinedEvents () {
      return this.joinedEvents.slice(this.pageSize * (this.page - 1), this.pageSize * (this.page))
    },
    joinedEventsLength () {
      return Math.ceil(this.joinedEvents.length / this.pageSize)
    }
  },
  methods: {
    pageChange (pageNumber) {
      this.displayJoinedEvents.slice(this.pageSize * (pageNumber - 1), this.pageSize * (pageNumber))
    },
    async cancelEvent (joinedEvent) {
      if (window.confirm('キャンセルしてもよろしいですか？')) {
        await this.$axios.$delete(`/api/v1/join_events/${joinedEvent.id}`)
          .then(
            (response) => {
              this.$store.commit('events/deleteJoinedEvent', joinedEvent.id, { root: true })
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