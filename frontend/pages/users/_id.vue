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
                  <v-avatar color="white" size="65">
                    <v-img
                      v-if="user.image_url"
                      :src="user.image_url"
                    />
                    <v-icon
                      v-else
                      size="80"
                    >
                      mdi-account-circle
                    </v-icon>
                  </v-avatar>
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
            centered
          >
            <v-tab v-for="title in titles" :key="title.name">
              {{ title.name }}
            </v-tab>
          </v-tabs>
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
        </v-col>
      </v-row>
    </v-card>
    <v-container>
      <v-tabs-items v-model="tabTitle">
        <v-tab-item>
          <v-container style="background-color:#FAFAFA;">
            <v-card>
              <v-card-title>自己紹介</v-card-title>
              <v-divider />
              <v-card-text>
                {{ user.description }}
              </v-card-text>
              <v-card-subtitle>登録したタグ</v-card-subtitle>
              <v-card-text>
                {{ user.tags }}
              </v-card-text>
              <v-card-title>経歴</v-card-title>
              <v-divider />
              <v-row justify="center" no-gutters>
                <v-col>
                  <v-subheader>チャート</v-subheader>
                  <BarChart
                    :height="200"
                    :width="200"
                  />
                </v-col>
                <v-col>
                  {{ user.liked_posts }}
                </v-col>
              </v-row>
            </v-card>
          </v-container>
        </v-tab-item>
        <v-tab-item>
          <v-container style="background-color:#FAFAFA;">
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
          talkroom
        </v-tab-item>
        <v-tab-item>
          <v-container style="background-color:#FAFAFA;">
            <template v-if="events.length > 0">
              <UserEvents
                :events="events"
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
      </v-tabs-items>
    </v-container>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import FollowBtnGroup from '~/components/molecles/users/FollowBtnGroup'
import BarChart from '~/components/organisms/users/BarChart'
import UserPosts from '~/components/organisms/users/UserPosts'
import UserEvents from '~/components/organisms/users/UserEvents'

export default {
  components: {
    FollowBtnGroup,
    UserPosts,
    UserEvents,
    BarChart
  },
  data () {
    return {
      tabTitle: null,
      titles: [
        { name: 'プロフィール詳細' },
        { name: '投稿レビュー' },
        { name: 'お気に入りツール' },
        { name: 'イベント' }
      ]
    }
  },
  async fetch ({ $axios, params, store }) {
    await $axios.get(`api/v1/users/${params.id}`)
      .then((response) => {
        store.commit('user/setUser', response.data, { root: true })
        console.log(response.data.liked_posts)
        store.commit('posts/setPosts', response.data.posts, { root: true })
        store.commit('events/setEvents', response.data.events, { root: true })
      })
      .catch((error) => {
        console.log(error)
        return error
      })
  },
  computed: {
    ...mapGetters({ user: 'user/user' }),
    ...mapGetters({ posts: 'posts/posts' }),
    ...mapGetters({ events: 'events/events' })
  }
}
</script>
