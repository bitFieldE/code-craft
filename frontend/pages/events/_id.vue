<template>
  <v-container>
    <v-row align="center" justify="center">
      <v-col cols="10">
        <v-card-title
          class="px-0"
        >
          {{ event.title }}
        </v-card-title>
        <v-card>
          <v-img
            :src="event.image_url ? event.image_url : '/images/no_img.png'"
            max-height="300"
          />
        </v-card>
      </v-col>
      <v-col cols="10">
        <v-row no-gutters>
          <v-col cols="12">
            <v-card-subtitle class="px-0 font-weight-bold">
              [参加者一覧]
            </v-card-subtitle>
          </v-col>
          <v-row
            v-if="event.join_users.length > 0"
            no-gutters
          >
            <v-col
              v-for="user in event.join_users"
              :key="user.id"
              cols="1"
            >
              <v-tooltip bottom>
                <template #activator="{ on, attrs }">
                  <div>
                    <v-avatar
                      v-if="user.image_url"
                      v-bind="attrs"
                      v-on="on"
                      size="35"
                    >
                      <v-img
                        :src="user.image_url"
                      />
                    </v-avatar>
                    <v-icon
                      v-else
                      v-bind="attrs"
                      v-on="on"
                      size="40"
                    >
                      mdi-account-circle
                    </v-icon>
                  </div>
                </template>
                <span>{{ user.name }}</span>
              </v-tooltip>
            </v-col>
          </v-row>
          <v-row v-else>
            <v-col
              cols="12"
            >
              <v-card-text>
                参加者はいません
              </v-card-text>
            </v-col>
          </v-row>
          <v-col cols="12">
            <v-card-text class="px-0">
              {{ event.join_users.length }} 人
            </v-card-text>
          </v-col>
        </v-row>
        <v-card>
          <v-card-text>
            <EventCommentArea
              :event="event"
            />
          </v-card-text>
          <v-card-text v-if="eventComments.length > 0">
            <EventComment
              v-for="comment in eventComments"
              :key="comment.id"
              class="mb-4"
              :comment="comment"
            />
          </v-card-text>
          <v-card-text v-else>
            まだメッセージがありません。まずは簡単な自己紹介をしてみましょう!
          </v-card-text>
        </v-card>
        <v-card-text class="px-0">
          <v-btn
            class="white--text"
            color="pink lighten-2"
            @click="cancelEvent(event)"
          >
            参加をキャンセルする
          </v-btn>
        </v-card-text>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import { mapGetters } from 'vuex'
import EventComment from '~/components/molecles/events/EventComment'
import EventCommentArea from '~/components/molecles/events/EventCommentArea'

export default {
  components: {
    EventComment,
    EventCommentArea
  },
  async fetch ({ $axios, params, store }) {
    await $axios.get(`api/v1/events/${params.id}`)
      .then((response) => {
        store.commit('events/setEvent', response.data, { root: true })
        store.commit('comments/setEventComments', response.data.event_comments, { root: true })
      })
      .catch((error) => {
        console.log(error)
        return error
      })
  },
  computed: {
    ...mapGetters({ event: 'events/event' }),
    ...mapGetters({ eventComments: 'comments/eventComments' })
  },
  mounted () {

  },
  methods: {
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
              this.$router.push(`/users/${this.$auth.user.id}`)
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
