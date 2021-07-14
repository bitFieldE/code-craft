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
            :post="post"
            :user="$auth.user"
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
        <nuxt-link
          :to="{ path: `/users/${post.user.id}` }"
          style="color: inherit; text-decoration: none;"
        >
          <v-card-text>
            <v-avatar
              v-if="post.user.image_url"
              size="20"
            >
              <v-img
                :src="post.user.image_url"
              />
            </v-avatar>
            <v-icon
              v-else
              size="20"
            >
              mdi-account-circle
            </v-icon>
            {{ post.user.name }}
          </v-card-text>
        </nuxt-link>
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
import AddStudyEvent from '~/components/molecles/users/AddStudyEvent'

export default {
  components: { AddStudyEvent },
  props: {
    posts: {
      type: Array,
      default: () => []
    },
    loading: {
      type: null,
      default: ''
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
    displayPosts () {
      return this.posts.slice(this.pageSize * (this.page - 1), this.pageSize * (this.page))
    },
    PostsLength () {
      return Math.ceil(this.posts.length / this.pageSize)
    }
  },
  methods: {
    pageChange (pageNumber) {
      this.displayPosts.slice(this.pageSize * (pageNumber - 1), this.pageSize * (pageNumber))
    }
  }
}
</script>
