<template>
  <div>
    <h3>{{ `参加人数: ${event.join_users.length}/${event.participant_number}` }}</h3>
    <v-btn
      :to="{ path: `/events/${event.id}` }"
      color="deep-purple lighten-5 white--text"
    >
      参加者ルーム
    </v-btn>
    <v-btn
      v-if="event.user.id!=$auth.user.id && !is_joined"
      @click="joinEvent(event.id)"
    >
      <v-icon>
        mdi-account-arrow-right
      </v-icon>
      参加する
    </v-btn>
    <v-btn
      v-else-if="event.participant_number > 0 && event.participant_number==event.join_users.length"
      disabled
    >
      上限人数に達しました
    </v-btn>
    <v-btn
      v-else
      disabled
    >
      <v-icon>
        mdi-account-arrow-right
      </v-icon>
      参加済み
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
  computed: {
    ...mapGetters({ joinedEvents: 'events/joinedEvents' }),
    is_joined () {
      return this.event.join_users.find(v => v.id === this.$auth.user.id)
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
            this.$store.commit('events/updateEvent', response.event, { root: true })
          },
          (error) => {
            return error
          }
        )
    }
  }
}
</script>
