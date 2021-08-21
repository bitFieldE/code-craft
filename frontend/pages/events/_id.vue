<template>
  <v-container>
    <v-row align="center" justify="center">
      <v-col cols="10">
        <v-card-title
          class="px-0 text-h5"
        >
          {{ event.title }}
        </v-card-title>
        <v-card>
          <v-img
            :src="event.image.url ? event.image.url : '/images/no_img.png'"
            max-height="400"
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
          <v-col cols="12">
            <v-card>
              <v-row
                v-if="event.join_users.length > 0"
                class="py-2 pl-2"
                no-gutters
              >
                <v-col
                  v-for="user in event.join_users"
                  :key="user.id"
                  style="max-width: 40px;"
                >
                  <v-tooltip bottom>
                    <template #activator="{ on, attrs }">
                      <nuxt-link
                        :to="{ path: `/users/${user.id}` }"
                        style="color: inherit; text-decoration: none;"
                      >
                        <v-avatar
                          v-if="user.image.url"
                          v-bind="attrs"
                          size="32"
                          style="margin-top: 3px;margin-left: 5px;"
                          v-on="on"
                        >
                          <v-img
                            :src="user.image.url"
                          />
                        </v-avatar>
                        <v-icon
                          v-else
                          v-bind="attrs"
                          size="40"
                          v-on="on"
                        >
                          mdi-account-circle
                        </v-icon>
                      </nuxt-link>
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
            </v-card>
          </v-col>
          <v-col cols="12">
            <v-card-text class="px-0 font-weight-bold">
              {{ event.join_users.length }} / {{ event.participant_number }} 人
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
        <v-card-text
          v-if="event.user.id!==$auth.user.id"
          class="px-0"
        >
          <v-btn
            class="white--text"
            color="pink lighten-2"
            @click="cancelEvent(event)"
          >
            <v-icon left>
              mdi-account-cancel-outline
            </v-icon>
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
  middleware: 'loginAuth',
  async fetch ({ $axios, params, store }) {
    await $axios.get(`api/v1/events/${params.id}`)
      .then((response) => {
        store.commit('events/setEvent', response.data, { root: true })
        store.commit('comments/setEventComments', response.data.event_comments, { root: true })
      })
      .catch((error) => {
        return error
      })
  },
  computed: {
    ...mapGetters({ event: 'events/event' }),
    ...mapGetters({ eventComments: 'comments/eventComments' })
  },
  mounted () {
    if (this.event.user.id !== this.$auth.user.id && !this.event.join_users.find(v => v.id === this.$auth.user.id)) {
      this.$router.push(`/users/${this.$auth.user.id}`)
    }
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
                  color: 'pink lighten-2',
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
