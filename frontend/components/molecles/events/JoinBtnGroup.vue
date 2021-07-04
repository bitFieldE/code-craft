<template>
  <div>
    <v-btn
      v-if="is_joined"
      :to="{ path: `/events/${event.id}` }"
      color="deep-purple lighten-5"
    >
      参加者ルーム
    </v-btn>
    <v-btn
      v-else-if="event.participant_number > 0 && event.participant_number==event.join_users.length"
      disabled
    >
      上限人数に達しました
    </v-btn>
    <v-btn
      v-else
      @click="joinEvent(event.id)"
    >
      <v-icon>
        mdi-account-arrow-right
      </v-icon>
      参加する
    </v-btn>
  </div>
</template>

<script>
export default {
  props: {
    event: {
      type: Object,
      default: () => {}
    }
  },
  data () {
    return {
      is_joined: false
    }
  },
  mounted () {
    if (this.event.join_users.find(v => v.id === this.$auth.user.id)) { this.is_joined = true }
  },
  methods: {
    async joinEvent (eventId) {
      const formData = new FormData()
      formData.append('join_event[event_id]', eventId)
      await this.$axios.$post('/api/v1/join_events', formData)
        .then(
          (response) => {
            this.is_joined = true
            console.log(response)
            this.$store.commit('events/addParticipant', response, { root: true })
          },
          (error) => {
            return error
          }
        )
    }
  }
}
</script>
