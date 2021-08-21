<template>
  <v-container>
    <v-row>
      <v-col
        cols="12"
      >
        <v-card>
          <v-card-subtitle>
            {{ $moment(post.created_at).format('YYYY/MM/DD HH:MM') }}
            <AddStudyEvent
              class="float-right ma-0"
              :post="post"
              :user="$auth.user"
            />
          </v-card-subtitle>
          <v-card-title>
            {{ post.title }}
          </v-card-title>
          <v-carousel
            v-if="post.images_url.length > 0"
            :continuous="false"
            :cycle="cycle"
            :show-arrows="false"
            hide-delimiter-background
            delimiter-icon="mdi-minus"
            height="300"
          >
            <v-carousel-item
              v-for="(image, i) in post.images_url"
              :key="i"
              :src="image.url"
            />
          </v-carousel>
          <v-card-text class="pb-0">
            <v-card-actions class="text-center">
              <v-rating
                :value="post.rate"
                color="yellow darken-3"
                background-color="darken-1"
                readonly
                half-increments
                dense
              />
              <span class="font-weight-bold">
                ({{ post.rate }})
              </span>
            </v-card-actions>
          </v-card-text>
          <v-divider />
          <!-- eslint-disable vue/no-v-html -->
          <div
            class="mx-4 mt-5"
            v-html="$md.render(post.content)"
          />
          <!-- eslint-enable -->
          <v-card-text
            v-if="post.tags"
            class="pb-0"
          >
            <v-chip-group
              active-class="primary--text"
              column
            >
              <v-chip
                v-for="tag in post.tags"
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
          <v-card-text class="py-0">
            <LikeBtnGroup
              v-if="$auth.loggedIn"
              :post="post"
            />
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
            <v-card-actions>
              <v-avatar
                v-if="post.user.image.url"
                color="black"
                size="40"
                class="mr-1"
              >
                <v-img
                  :src="post.user.image.url"
                />
              </v-avatar>
              <v-icon
                v-else
                size="45"
              >
                mdi-account-circle
              </v-icon>
              <nuxt-link
                :to="{ path: `/users/${post.user.id}` }"
                style="color: inherit; text-decoration: none;"
              >
                <span class="pl-2">
                  {{ post.user.name }}
                </span>
              </nuxt-link>
              <FollowBtnGroup
                :user="post.user"
              />
            </v-card-actions>
            <v-card-text>
              {{ post.user.description }}
            </v-card-text>
          </v-container>
        </v-card>
      </v-col>
    </v-row>
    <v-card class="mt-10">
      <v-card-title>
        コメント一覧
      </v-card-title>
      <v-divider />
      <v-container>
        <v-row justify="center">
          <v-col
            v-if="comments.length > 0"
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
            v-else
            cols="12"
          >
            <v-card-text>コメントがありません</v-card-text>
          </v-col>
          <v-col cols="12">
            <v-card-text
              v-if="$auth.loggedIn"
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
import LikeBtnGroup from '~/components/molecles/posts/LikeBtnGroup'
import AddStudyEvent from '~/components/molecles/users/AddStudyEvent'
import FollowBtnGroup from '~/components/molecles/users/FollowBtnGroup'

export default {
  components: {
    TwitterBtn,
    Comment,
    CommentArea,
    LikeBtnGroup,
    AddStudyEvent,
    FollowBtnGroup
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
