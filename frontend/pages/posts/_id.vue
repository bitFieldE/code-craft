<template>
  <v-container>
    <v-row>
      <v-col
        cols="12"
      >
        <v-card>
          <v-card-subtitle>
            {{ post.created_date }}
          </v-card-subtitle>
          <v-card-title>
            <h4>{{ post.title }}</h4>
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
            <span class="font-weight-bold">
              ({{ post.rate }})
            </span>
            <v-rating
              :value="post.rate"
              color="yellow darken-3"
              background-color="grey darken-1"
              readonly
              half-increments
              dense
              small
            />
          </v-card-text>
          <v-divider />
          <!-- eslint-disable vue/no-v-html -->
          <v-card-text v-html="$md.render(post.content)" />
          <!-- eslint-enable -->
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
          <v-card-text>
            <TwitterBtn
              :post="post"
            />
          </v-card-text>
        </v-card>
      </v-col>
      <v-col
        cols="12"
      >
        <v-card>
          <v-container>
            {{ post.user.name }}
            {{ post.user.description }}
          </v-container>
        </v-card>
      </v-col>
    </v-row>
    <v-card class="mt-10">
      <v-card-title>
        コメント一覧
      </v-card-title>
      <v-divider />
      <v-container v-if="comments">
        <v-row justify="center">
          <v-col
            cols="12"
            sm="12"
            lg="10"
          >
            <Comment
              v-for="comment in comments"
              :key="comment.id"
              class="mt-4"
              :comment="comment"
            />
          </v-col>
          <v-col
            cols="12"
            sm="12"
            lg="10"
          >
            <v-card-text
              v-if="$auth.isAuthenticated()"
              class="px-0"
            >
              <CommentArea
                :post="post"
              />
            </v-card-text>
            <template
              v-else
            >
              <v-card-text class="pb-0">
                <v-btn
                  to="/signup"
                  color="warning"
                >
                  会員登録
                </v-btn>
              </v-card-text>
              <v-card-text>
                <span>すでにアカウントをお持ちですか？</span>
                <nuxt-link to="/login">
                  ログインに移動
                </nuxt-link>
              </v-card-text>
            </template>
          </v-col>
        </v-row>
      </v-container>
    </v-card>
  </v-container>
</template>

<script>
import { mapGetters } from 'vuex'
import TwitterBtn from '~/components/atoms/posts/TwitterBtn'
import Comment from '~/components/molecles/posts/Comment'
import CommentArea from '~/components/molecles/posts/CommentArea'

export default {
  components: {
    TwitterBtn,
    CommentArea,
    Comment
  },
  async fetch ({ $axios, params, store }) {
    await $axios.get(`api/v1/posts/${params.id}`)
      .then((response) => {
        store.commit('posts/setPost', response.data, { root: true })
        store.commit('comments/setComments', response.data.comments, { root: true })
      })
      .catch((error) => {
        console.log(error)
        return error
      })
  },
  computed: {
    ...mapGetters({
      post: 'posts/post',
      comments: 'comments/comments'
    })
  }
}
</script>
