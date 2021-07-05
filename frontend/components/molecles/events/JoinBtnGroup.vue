<template>
  <div>
    <h3>{{ `参加人数: ${participants.length}/${event.participant_number}` }}</h3>
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
import { mapGetters } from 'vuex'

export default {
  props: {
    event: {
      type: Object,
      default: () => {}
    }
  },
  mounted () {
    this.$store.commit('events/setParticipants', this.event.join_users, { root: true })
  },
  computed: {
    ...mapGetters({ joinedEvents: 'events/joinedEvents' }),
    ...mapGetters({ participants: 'events/participants' }),
    is_joined () {
      return this.joinedEvents.find(v => v.id === this.event.id)
    }
  },
  methods: {
    async joinEvent (eventId) {
      const formData = new FormData()
      formData.append('join_event[event_id]', eventId)
      await this.$axios.$post('/api/v1/join_events', formData)
        .then(
          (response) => {
            this.is_joined = true
            this.$store.commit('events/addJoinedEvent', response.event, { root: true })
            this.$store.commit('events/addParticipant', response.user, { root: true })
          },
          (error) => {
            return error
          }
        )
    }
  }
}
</script>
