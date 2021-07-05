<template>
  <v-container>
    <v-row>
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
          </v-img>
          <v-card-title class="text-h5">
            {{ joinedEvent.title }}
          </v-card-title>
          <v-card-subtitle>
            {{ $moment(joinedEvent.scheduled_date).format('YYYY/MM/DD') }}
          </v-card-subtitle>
          <v-card-text class="pt-0">
            <v-btn
              :to="{ path: `/events/${joinedEvent.id}` }"
              color="deep-purple lighten-5"
            >
              参加者ルーム
            </v-btn>
            <v-btn
              class="pt-0"
              color="pink accent-2"
              @click="cancelEvent(joinedEvent)"
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
        :length="joinedEventsLength"
        @input="pageChange"
      />
    </v-card-text>
  </v-container>
</template>

<script>
export default {
  props: {
    joinedEvents: {
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
              this.$store.commit('events/deleteParticipants', this.$auth.user.id, { root: true })
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
