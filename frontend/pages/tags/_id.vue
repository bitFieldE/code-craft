<template>
  <v-container>
    <v-row align="center" justify="center">
      <v-col xs="12" sm="7" md="4" lg="8">
        <v-card>
          <v-card-title>
            {{ tag.name }}
          </v-card-title>
          <v-card-text
            v-if="$auth.loggedIn"
          >
            <TagFollowBtnGroup
              :tag="tag"
            />
          </v-card-text>
        </v-card>
      </v-col>
      <v-col xs="12" sm="8" md="6" lg="10">
        <v-card>
          <v-tabs
            v-model="tab"
            fixed-tabs
            centered
            next-icon="mdi-arrow-right-bold-box-outline"
            prev-icon="mdi-arrow-left-bold-box-outline"
            show-arrows
            color="secondary"
            background-color="brown lighten-5"
          >
            <v-tab>
              投稿
            </v-tab>
            <v-tab>
              イベント
            </v-tab>
          </v-tabs>
          <v-tabs-items v-model="tab" touchless>
            <v-tab-item>
              <v-container>
              </v-container>
            </v-tab-item>
            <v-tab-item>
              <v-container>
                イベント
              </v-container>
            </v-tab-item>
          </v-tabs-items>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import { mapGetters } from 'vuex'
import TagFollowBtnGroup from '~/components/molecles/tags/TagFollowBtnGroup'

export default {
  components: { TagFollowBtnGroup },
  data () {
    return {
      tab: null,
      loading: false
    }
  },
  async fetch ({ $axios, params, store }) {
    await $axios.get(`api/v1/tags/${params.id}`)
      .then((response) => {
        store.commit('tags/setTag', response.data.tag, { root: true })
        store.commit('tags/setPosts', response.data.posts, { root: true })
        store.commit('tags/setEvents', response.data.events, { root: true })
      })
      .catch((error) => {
        console.log(error)
        return error
      })
  },
  computed: {
    ...mapGetters({ tag: 'tags/tag' }),
    ...mapGetters({ posts: 'tags/posts' }),
    ...mapGetters({ events: 'tags/events' })
  }
}
</script>
