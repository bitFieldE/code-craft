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
          <template>
            <div
              v-for="user in event.join_users"
              :key="user.id"
            >
              <v-avatar v-if="user.image_url">
                <v-img
                  :src="user.image_url"
                />
              </v-avatar>
              <v-icon
                v-else
                size="54"
              >
                mdi-account-circle
              </v-icon>
            </div>
          </template>
        </v-col>
      </v-row>
      <v-card-text>
        <EventComment />
      </v-card-text>
    </v-card>
  </v-container>
</template>

<script>
import { mapGetters } from 'vuex'
import EventComment from '~/components/molecles/events/EventComment'

export default {
  components: { EventComment },
  data () {
    return {

    }
  },
  async fetch ({ $axios, params, store }) {
    await $axios.get(`api/v1/events/${params.id}`)
      .then((response) => {
        store.commit('events/setEvent', response.data, { root: true })
      })
      .catch((error) => {
        console.log(error)
        return error
      })
  },
  computed: {
    ...mapGetters({ event: 'events/event' })
  }
}
</script>
