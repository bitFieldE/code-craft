<template>
  <v-container class="col-xs-12 col-sm-10 col-md-10">
    <v-card>
      <v-card-title>
        {{ post.title }}
      </v-card-title>
      <v-carousel
        v-if="post.images_data.length > 0"
        :continuous="false"
        :cycle="cycle"
        :show-arrows="false"
        hide-delimiter-background
        delimiter-icon="mdi-minus"
        height="300"
      >
        <v-carousel-item
          v-for="(image, i) in post.images_data"
          :key="i"
          :src="image.url"
        />
      </v-carousel>
      <v-card-text class="text-center">
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
      <v-divider />
      <!-- eslint-disable vue/no-v-html -->
      <v-card-text v-html="$md.render(post.content)" />
      <!-- eslint-enable -->
      <v-card-text>
        <CommentArea />
      </v-card-text>
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
          >
            {{ tag.name }}
          </v-chip>
        </v-chip-group>
      </v-card-text>
      <v-card-text>
        <TwitterBtn
          :post="post"
        />
      </v-card-text>
    </v-card>
  </v-container>
</template>

<script>
import { mapGetters } from 'vuex'
import TwitterBtn from '~/components/atoms/posts/TwitterBtn'
import CommentArea from '~/components/organisms/posts/CommentArea'

export default {
  components: {
    TwitterBtn,
    CommentArea
  },
  async fetch ({ $axios, params, store }) {
    await $axios.get(`api/v1/posts/${params.id}`)
      .then((response) => {
        store.commit('posts/setPost', response.data, { root: true })
      })
      .catch((error) => {
        console.log(error)
        return error
      })
  },
  computed: {
    ...mapGetters({
      post: 'posts/post'
    })
  }
}
</script>
