<template>
  <v-container>
    <v-card>
      <v-row align="center" justify="center">
        <v-col cols="10">
          <v-card-title>{{ event.title }}</v-card-title>
          <v-card>
            <v-img
              :src="event.image_url ? event.image_url : '/images/no_img.png'"
              max-height="300"
            />
          </v-card>
        </v-col>
        <v-col cols="10">
          <template>
            <div
              v-for="user in event.join_users"
              :key="user.id"
            >
              <v-avatar
                v-if="user.image_url"
                size="40"
              >
                <v-img
                  :src="user.image_url"
                />
              </v-avatar>
              <v-icon
                v-else
                size="40"
              >
                mdi-account-circle
              </v-icon>
            </div>
          </template>
          <v-card-text>
            <EventCommentArea
              :event="event"
            />
          </v-card-text>
          <v-card-text>
            <EventComment
              v-for="comment in eventComments"
              :key="comment.id"
              :comment="comment"
            />
          </v-card-text>
        </v-col>
      </v-row>
    </v-card>
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
  data () {
    return {

    }
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
  }
}
</script>
