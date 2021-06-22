<template>
  <div>
    <v-card
      tile
      color="greyLight4"
    >
      <v-row align="center" justify="center" no-gutters>
        <v-col xs="12" sm="10" md="8" lg="6">
          <v-layout class="py-3 pl-13" align-content-center>
            <v-avatar v-if="user.image_url" color="white" size="65">
              <v-img :src="user.image_url" />
            </v-avatar>
            <v-avatar v-else color="black" size="65">
              <v-icon color="white" size="80">
                mdi-account-circle
              </v-icon>
            </v-avatar>
            <v-list color="greyLight4">
              <v-list-item class="py-0 form-inline">
                {{ user.name }}
                <div v-if="$auth.loggedIn && user.id !== $auth.user.id">
                  <v-btn
                    v-if="is_followed"
                    class="ml-2"
                    color="info"
                    rounded
                    @click="unFollowUser"
                  >
                    アンフォロー
                  </v-btn>
                  <v-btn
                    v-else
                    class="ml-2"
                    color="warning"
                    rounded
                    @click="followUser"
                  >
                    フォロー
                  </v-btn>
                </div>
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
            background-color="greyLight4"
            color="info"
            centered
          >
            <v-tab v-for="title in titles" :key="title.name">
              {{ title.name }}
            </v-tab>
          </v-tabs>
          <v-tabs
            v-model="tabTitle"
            class="d-inline d-sm-none"
            background-color="greyLight4"
            fixed-tabs
            color="info"
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
          <v-card
            class="mx-1 my-10"
            color="greyLight4"
          >
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
              <v-col>HOGE</v-col>
            </v-row>
          </v-card>
        </v-tab-item>
        <v-tab-item>
          <v-container>
            <v-card
              v-for="post in user.posts"
              :key="post.id"
              class="mb-8"
            >
              <nuxt-link
                :to="{ path: `/posts/${post.id}` }"
                style="color: inherit; text-decoration: none;"
              >
                <v-card-title style="font-size: 15px;">
                  {{ post.title }}
                </v-card-title>
                <v-card-text>
                  <v-rating
                    :value="post.rate"
                    color="yellow darken-3"
                    background-color="grey darken-1"
                    readonly
                    half-increments
                    small
                  />
                  <span class="font-weight-bold">
                    {{ post.rate }}
                  </span>
                </v-card-text>
              </nuxt-link>
              <v-card-text v-if="post.tags">
                <v-chip-group
                  active-class="primary--text"
                  column
                >
                  <v-chip
                    v-for="tag in post.tags"
                    :key="tag"
                    color="info"
                    outlined
                    small
                  >
                    {{ tag.name }}
                  </v-chip>
                </v-chip-group>
              </v-card-text>
            </v-card>
          </v-container>
        </v-tab-item>
        <v-tab-item>
          talkroom
        </v-tab-item>
        <v-tab-item>
          <v-container>
            <v-btn color="warning">
              イベントを作成する
            </v-btn>
          </v-container>
        </v-tab-item>
      </v-tabs-items>
    </v-container>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import BarChart from '~/components/organisms/users/BarChart'

export default {
  components: {
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
      ],
      is_followed: false
    }
  },
  async fetch ({ $axios, params, store }) {
    await $axios.get(`api/v1/users/${params.id}`)
      .then((response) => {
        store.commit('user/setUser', response.data, { root: true })
      })
      .catch((error) => {
        console.log(error)
        return error
      })
  },
  computed: {
    ...mapGetters({ user: 'user/user' })
  },
  created () {
    if (this.user.followers.find(v => v.id === this.$auth.user.id)) { this.is_followed = true }
  },
  methods: {
    async followUser () {
      const formData = new FormData()
      formData.append('follow_id', this.user.id)
      await this.$axios.$post('/api/v1/relationships', formData)
        .then(
          (response) => {
            this.is_followed = true
            this.$store.commit('user/setUser', response.user, { root: true })
            this.$store.dispatch(
              'flash/showMessage',
              {
                message: response.message,
                color: 'success',
                status: true
              },
              { root: true }
            )
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
    },
    async unFollowUser () {
      await this.$axios.$delete(`/api/v1/relationships/${this.user.id}`)
        .then(
          (response) => {
            this.is_followed = false
            this.$store.commit('user/setUser', response.user, { root: true })
            this.$store.dispatch(
              'flash/showMessage',
              {
                message: response.message,
                color: 'success',
                status: true
              },
              { root: true }
            )
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
</script>
