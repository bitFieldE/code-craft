<template>
  <div>
    <v-card
      tile
      color="brown lighten-5"
    >
      <v-row align="center" justify="center" no-gutters>
        <v-col xs="12" sm="10" md="8" lg="6">
          <v-layout class="py-3 pl-13" align-content-center>
            <v-list color="brown lighten-5">
              <v-list-item>
                <v-card-actions>
                  <v-avatar
                    v-if="user.image_url"
                    color="white"
                    size="65"
                  >
                    <v-img
                      :src="user.image_url"
                    />
                  </v-avatar>
                  <v-icon
                    v-else
                    size="65"
                  >
                    mdi-account-circle
                  </v-icon>
                  <span class="pl-2">{{ user.name }}</span>
                  <FollowBtnGroup
                    :user="user"
                  />
                </v-card-actions>
              </v-list-item>
              <v-list-item>
                <v-card-subtitle class="pa-0">
                  フォロー {{ user.followings.length }}
                </v-card-subtitle>
                <v-card-subtitle>
                  フォワー {{ user.followers.length }}
                </v-card-subtitle>
              </v-list-item>
            </v-list>
          </v-layout>
          <v-divider />
          <v-tabs
            v-model="tabTitle"
            class="d-none d-sm-inline"
            background-color="brown lighten-5"
            color="secondary"
            show-arrows
            centered
          >
            <v-tab v-for="title in titles" :key="title.name">
              {{ title.name }}
            </v-tab>
          </v-tabs>
          <div class="d-inline d-sm-none py-0">
            <div class="text-center">
              <v-btn
                icon
                @click="show = !show"
              >
                <v-icon
                  size="30"
                >
                  {{ show ? 'mdi-chevron-up' : 'mdi-chevron-down' }}
                </v-icon>
              </v-btn>
            </div>
          </div>
          <v-divider />
          <v-expand-transition>
            <div v-show="show">
              <v-tabs
                v-model="tabTitle"
                class="d-inline d-sm-none"
                background-color="brown lighten-5"
                fixed-tabs
                color="secondary"
                vertical
              >
                <v-tab v-for="title in titles" :key="title.name">
                  {{ title.name }}
                </v-tab>
              </v-tabs>
            </div>
          </v-expand-transition>
        </v-col>
      </v-row>
    </v-card>
    <v-container>
      <v-tabs-items v-model="tabTitle">
        <v-tab-item>
          <v-container class="grey lighten-5">
            <v-card>
              <v-card-title>自己紹介</v-card-title>
              <v-divider />
              <v-card-text>
                {{ user.description }}
              </v-card-text>
              <v-card-subtitle class="pb-0">
                登録したタグ
              </v-card-subtitle>
              <v-card-text
                v-if="user.tags"
                class="pb-0"
              >
                <v-chip-group
                  active-class="primary--text"
                  column
                >
                  <v-chip
                    v-for="tag in user.tags"
                    :key="tag.id"
                    color="info"
                    outlined
                    small
                  >
                    <nuxt-link
                      :to="{ path: `/tags/${tag.id}` }"
                      style="color: inherit; text-decoration: none;"
                    >
                      {{ tag.name }}
                    </nuxt-link>
                  </v-chip>
                </v-chip-group>
              </v-card-text>
              <v-card-text v-else>
                登録したタグはありません
              </v-card-text>
              <v-card-title>
                嗜好トレンド
              </v-card-title>
              <v-divider />
              <template v-if="user.tag_ranking.length > 0">
                <v-row justify="center" no-gutters>
                  <v-col>
                    <v-subheader>タグ</v-subheader>
                    <BarChart
                      class="my-4 mx-2"
                      :height="200"
                      :width="200"
                      :tags="user.tag_ranking"
                    />
                  </v-col>
                </v-row>
              </template>
              <template v-else>
                <v-row justify="center" no-gutters>
                  <v-col class="my-4 mx-2">
                    <v-card>
                      <v-card-text>
                        タグをつけた投稿
                      </v-card-text>
                    </v-card>
                  </v-col>
                </v-row>
              </template>
            </v-card>
          </v-container>
        </v-tab-item>
        <v-tab-item>
          <v-container class="grey lighten-5">
            <template v-if="posts.length > 0">
              <v-card-text v-if="$auth.user.id==user.id">
                <v-btn
                  color="primary"
                  to="/posts/new"
                >
                  投稿作成
                </v-btn>
              </v-card-text>
              <UserPosts
                :posts="posts"
                :loading="loading"
              />
            </template>
            <template v-else>
              <v-card>
                <v-card-text>
                  投稿記事がありません
                </v-card-text>
                <div v-if="user.id==$auth.user.id">
                  <v-divider />
                  <v-card-text>
                    <v-btn
                      color="warning"
                      to="/posts/new"
                    >
                      投稿/レビューを行う
                    </v-btn>
                  </v-card-text>
                </div>
              </v-card>
            </template>
          </v-container>
        </v-tab-item>
        <v-tab-item>
          <v-container class="grey lighten-5">
            <template v-if="likedPosts.length > 0">
              <UserLikedPosts
                :posts="likedPosts"
                :loading="loading"
              />
            </template>
            <template v-else>
              <v-card>
                <v-card-text>
                  お気に入り記事がありません
                </v-card-text>
              </v-card>
            </template>
          </v-container>
        </v-tab-item>
        <v-tab-item>
          <v-container class="grey lighten-5">
            <template v-if="events.length > 0">
              <UserEvents
                :events="events"
                :loading="loading"
              />
            </template>
            <template v-else>
              <v-card>
                <v-card-text>
                  主催イベントがありません
                </v-card-text>
              </v-card>
            </template>
          </v-container>
        </v-tab-item>
        <v-tab-item>
          <v-container class="grey lighten-5">
            <template v-if="joinedEvents.length > 0">
              <UserJoinedEvents
                :events="joinedEvents"
                :user="user"
                :loading="loading"
              />
            </template>
            <template v-else>
              <v-card>
                <v-card-text>
                  参加予定のイベントがありません
                </v-card-text>
              </v-card>
            </template>
          </v-container>
        </v-tab-item>
      </v-tabs-items>
    </v-container>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import FollowBtnGroup from '~/components/molecles/users/FollowBtnGroup'
import BarChart from '~/components/organisms/users/BarChart'
import UserEvents from '~/components/organisms/users/UserEvents'
import UserJoinedEvents from '~/components/organisms/users/UserJoinedEvents'
import UserLikedPosts from '~/components/organisms/users/UserLikedPosts'
import UserPosts from '~/components/organisms/users/UserPosts'

export default {
  components: {
    FollowBtnGroup,
    BarChart,
    UserEvents,
    UserJoinedEvents,
    UserLikedPosts,
    UserPosts
  },
  data () {
    return {
      tabTitle: null,
      show: false,
      titles: [
        { name: 'プロフィール詳細' },
        { name: '投稿レビュー' },
        { name: 'お気に入りツール' },
        { name: 'イベント' },
        { name: '参加イベント' }
      ],
      loading: null,
      tagNameList: []
    }
  },
  async fetch ({ $axios, params, store }) {
    await $axios.get(`api/v1/users/${params.id}`)
      .then((response) => {
        store.commit('user/setUser', response.data, { root: true })
        store.commit('posts/setPosts', response.data.posts, { root: true })
        store.commit('posts/setLikedPosts', response.data.liked_posts, { root: true })
        store.commit('events/setEvents', response.data.events, { root: true })
        if (response.data.join_events.length > 0) {
          const joinedEvents = []
          response.data.join_events.forEach((joinEvent) => {
            joinedEvents.push(joinEvent.event)
          })
          store.commit('events/setJoinedEvents', joinedEvents, { root: true })
        }
      })
      .catch((error) => {
        console.log(error)
        return error
      })
  },
  computed: {
    ...mapGetters({ user: 'user/user' }),
    ...mapGetters({ posts: 'posts/posts' }),
    ...mapGetters({ likedPosts: 'posts/likedPosts' }),
    ...mapGetters({ events: 'events/events' }),
    ...mapGetters({ joinedEvents: 'events/joinedEvents' })
  },
  mounted () {
    this.loading = true
    setTimeout(this.stopLoading, 3000)
  },
  methods: {
    stopLoading () {
      this.loading = false
    }
  }
}
</script>
