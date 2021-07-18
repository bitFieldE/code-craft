<template>
  <div>
    <template v-if="loading">
      <v-card
        v-for="n in 5"
        :key="n"
        class="mb-8"
      >
        <v-skeleton-loader
          type="article, actions"
        />
      </v-card>
    </template>
    <template v-else>
      <v-card
        v-for="post in displayPosts"
        :key="post.id"
        class="mb-8"
      >
        <v-card-text class="pb-0">
          {{ $moment(post.created_at).format('YYYY/MM/DD HH:MM') }}
          <AddStudyEvent
            v-if="$auth.loggedIn"
            :post="post"
            :user="user"
          />
        </v-card-text>
        <nuxt-link
          :to="{ path: `/posts/${post.id}` }"
          style="color: inherit; text-decoration: none;"
        >
          <v-card-title class="pb-0" style="font-size: 15px;">
            {{ post.title }}
          </v-card-title>
          <v-card-actions class="ml-2">
            <v-rating
              :value="post.rate"
              color="yellow darken-3"
              background-color="grey darken-1"
              readonly
              half-increments
              dense
              small
            />
            <span class="rate pl-1">
              ( {{ post.rate }} )
            </span>
          </v-card-actions>
        </nuxt-link>
        <v-card-text class="py-0">
          <v-chip-group
            v-if="post.tags.length > 0"
            class="w-100"
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
        <v-card-text
          v-if="$auth.loggedIn&&$auth.user.id==post.user_id"
          class="pt-0"
        >
          <v-btn
            :to="{ path: `/posts/edit/${post.id}` }"
            icon
          >
            <v-icon>
              mdi-square-edit-outline
            </v-icon>
          </v-btn>
          <v-btn
            icon
            @click="deletePost(post.id)"
          >
            <v-icon>
              mdi-trash-can-outline
            </v-icon>
          </v-btn>
        </v-card-text>
      </v-card>
    </template>
    <v-pagination
      v-model="page"
      color="info"
      :length="PostsLength"
      @input="pageChange"
    />
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import AddStudyEvent from '~/components/molecles/users/AddStudyEvent'

export default {
  components: {
    AddStudyEvent
  },
  props: {
    posts: {
      type: Array,
      default: () => []
    },
    loading: {
      type: Boolean,
      default: null
    }
  },
  data () {
    return {
      page: 1,
      length: 0,
      pageSize: 5
    }
  },
  computed: {
    ...mapGetters({ user: 'user/user' }),
    displayPosts () {
      return this.posts.slice(this.pageSize * (this.page - 1), this.pageSize * (this.page))
    },
    PostsLength () {
      return Math.ceil(this.posts.length / this.pageSize)
    }
  },
  methods: {
    async deletePost (postId) {
      if (window.confirm('投稿を削除してもよろしいですか？(※関連する勉強会も削除されます)')) {
        await this.$axios.$delete(`/api/v1/posts/${postId}`)
          .then(
            (response) => {
              this.$store.commit('posts/deletePost', postId, { root: true })
              this.$store.commit('posts/deleteLikedPost', postId, { root: true })
              this.$store.commit('events/deleteEvents', postId, { root: true })
              this.$store.dispatch(
                'flash/showMessage',
                {
                  message: response.message,
                  color: 'primary',
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
    },
    pageChange (pageNumber) {
      this.displayPosts.slice(this.pageSize * (pageNumber - 1), this.pageSize * (pageNumber))
    }
  }
}
</script>

<style>
.rate {
  font-size: 12px;
}
</style>
