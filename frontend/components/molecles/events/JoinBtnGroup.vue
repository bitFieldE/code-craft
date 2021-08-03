<template>
  <div>
    <h4>{{ `参加人数: ${join_users_count}/${event.participant_number}` }}</h4>
    <v-btn
      v-if="event.user.id == $auth.user.id || is_joined"
      :to="{ path: `/events/${event.id}` }"
      color="deep-purple white--text"
    >
      参加者専用ルーム
    </v-btn>
    <v-btn
      v-else-if="event.participant_number > 0 && event.participant_number<=event.join_users.length"
      disabled
    >
      上限人数に達しました
    </v-btn>
    <v-btn
      v-else-if="event.user.id!=$auth.user.id && !is_joined"
      color="purple lighten-3 white--text"
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
      is_joined: false,
      join_users_count: this.event.join_users.length
    }
  },
  mounted () {
    if (this.event.join_users.find(v => v.id === this.$auth.user.id)) {
      this.is_joined = true
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
            this.join_users_count++
            this.$store.dispatch(
              'flash/showMessage',
              {
                message: 'イベントに参加しました',
                color: 'purple lighten-3',
                status: true
              },
              { root: true }
            )
          },
          (error) => {
            return error
          }
        )
    }
  }
}
</script>
