<template>
  <div>
    <v-card
      v-for="post in displayLikedPosts"
      :key="post.id"
      class="mb-8"
    >
      <nuxt-link
        :to="{ path: `/posts/${post.id}` }"
        style="color: inherit; text-decoration: none;"
      >
        <v-card-text>
          {{ $moment(post.created_at).format('YYYY/MM/DD HH:MM') }}
        </v-card-text>
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
            {{ tag.name }}
          </v-chip>
        </v-chip-group>
      </v-card-text>
      <v-card-text
        v-if="$auth.loggedIn"
        class="pt-0"
      >
        <LikeBtnGroup
          :post="post"
        />
      </v-card-text>
    </v-card>
    <v-pagination
      v-model="page"
      color="info"
      :length="LikedPostsLength"
      @input="pageChange"
    />
  </div>
</template>

<script>
import LikeBtnGroup from '~/components/molecles/posts/LikeBtnGroup'

export default {
  components: {
    LikeBtnGroup
  },
  props: {
    likedPosts: {
      type: Array,
      default: () => []
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
    displayLikedPosts () {
      return this.likedPosts.slice(this.pageSize * (this.page - 1), this.pageSize * (this.page))
    },
    LikedPostsLength () {
      return Math.ceil(this.likedPosts.length / this.pageSize)
    }
  },
  methods: {
    pageChange (pageNumber) {
      this.displayLikedPosts.slice(this.pageSize * (pageNumber - 1), this.pageSize * (pageNumber))
    }
  }
}
</script>

<style>
.rate {
  font-size: 12px;
}
</style>
