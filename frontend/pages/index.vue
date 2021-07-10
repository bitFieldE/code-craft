<template>
  <div>
    <v-img
      dark
      src="images/top_img.jpg"
      gradient="to top right, rgba(201, 214, 255, .6), rgba(226, 226, 226, .9)"
      :height="imgHeight"
    >
      <v-container>
        <v-row
          align="center"
          justify="center"
          :style="{ height: `${imgHeight}px` }"
        >
          <v-col
            cols="12"
            class="text-center"
          >
            <h1
              class="display-1 mb-4"
              :style="{ letterSpacing: '15px' }"
            >
              技術選定ではもう迷わない
            </h1>
            <h3
              class="subheading"
              :style="{ letterSpacing: '5px' }"
            >
              開発で使うツールのレビュー/勉強会
            </h3>
          </v-col>
        </v-row>
      </v-container>
    </v-img>
    <div>
      <v-container>
        <v-row>
          <v-col cols="12">
            <v-card-text class="text-h6 font-weight-light">
              急上昇記事
            </v-card-text>
            <FamousPosts
             :posts="famousPosts"
            />
          </v-col>
        </v-row>
      </v-container>
    </div>
    <div>
      <v-container>
        <v-row>
          <v-col cols="12">
            <v-card-text class="text-h6">
              開催間近イベント
            </v-card-text>
            <ComingSoonEvent
              :events="comingSoonEvents"
            />
          </v-col>
        </v-row>
      </v-container>
    </div>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import ComingSoonEvent from '~/components/organisms/top/ComingSoonEvent'
import FamousPosts from '~/components/organisms/top/FamousPosts'

export default {
  components: {
    ComingSoonEvent,
    FamousPosts
  },
  data () {
    return {
      model: [],
      imgHeight: 250
    }
  },
  async fetch ({ $axios, store, $config }) {
    console.log($config.baseURL)
    await $axios.get('api/v1/top')
      .then((response) => {
        console.log(response.data.tag_posts)
        store.commit('posts/setFamousPosts', response.data.posts, { root: true })
        store.commit('events/setComingSoonEvents', response.data.events, { root: true })
      })
      .catch((error) => {
        console.log(error)
        return error
      })
  },
  computed: {
    ...mapGetters({ famousPosts: 'posts/famousPosts' }),
    ...mapGetters({ comingSoonEvents: 'events/comingSoonEvents' })
  }
}
</script>
