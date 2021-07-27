<template>
  <v-container>
    <v-row justify="center">
      <v-col lg="4" md="4" sm="8" cols="12">
        <v-card>
          <v-card-title>
            {{ tag.name }}
          </v-card-title>
          <v-card-text>
            <v-row no-gutters>
              <v-col cols="12">
                <span class="font-weight-bold pr-2">
                  フォロワー
                </span>
                {{ tag.users.length }}
              </v-col>
              <v-col cols="12">
                <span class="font-weight-bold pr-2">
                  投稿
                </span>
                {{ tag.posts.length }}
              </v-col>
              <v-col cols="12">
                <span class="font-weight-bold pr-2">
                  イベント
                </span>
                {{ tag.events.length }}
              </v-col>
            </v-row>
          </v-card-text>
          <v-card-text
            v-if="$auth.loggedIn"
            class="pt-0"
          >
            <TagFollowBtnGroup
              :tag="tag"
            />
          </v-card-text>
        </v-card>
      </v-col>
      <v-col lg="8" md="8" sm="10" cols="12">
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
                <template v-if="posts.length > 0">
                  <TagPosts
                    :posts="posts"
                    :loading="loading"
                  />
                </template>
                <template v-else>
                  <v-card>
                    <v-card-text>
                      該当するレビュー記事がありません
                    </v-card-text>
                  </v-card>
                </template>
              </v-container>
            </v-tab-item>
            <v-tab-item>
              <v-container>
                <template v-if="events.length > 0">
                  <TagEvents
                    :events="events"
                    :loading="loading"
                  />
                </template>
                <template v-else>
                  <v-card>
                    <v-card-text>
                      該当するイベントがありません
                    </v-card-text>
                  </v-card>
                </template>
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
import TagEvents from '~/components/organisms/tags/TagEvents'
import TagPosts from '~/components/organisms/tags/TagPosts'

export default {
  components: {
    TagFollowBtnGroup,
    TagEvents,
    TagPosts
  },
  data () {
    return {
      tab: null,
      loading: false
    }
  },
  async fetch ({ $axios, params, store }) {
    await $axios.get(`api/v1/tags/${params.id}`)
      .then((response) => {
        store.commit('tags/setTag', response.data, { root: true })
        store.commit('tags/setPosts', response.data.posts, { root: true })
        store.commit('tags/setEvents', response.data.events, { root: true })
      })
      .catch((error) => {
        return error
      })
  },
  computed: {
    ...mapGetters({ tag: 'tags/tag' }),
    ...mapGetters({ posts: 'tags/posts' }),
    ...mapGetters({ events: 'tags/events' })
  },
  mounted () {
    this.loading = true
    setTimeout(this.stopLoading, 1000)
  },
  methods: {
    stopLoading () {
      this.loading = false
    }
  }
}
</script>
