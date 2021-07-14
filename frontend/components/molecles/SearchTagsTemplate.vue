<template>
  <div>
    <v-row v-if="loading">
      <v-col cols="12">
        <v-skeleton-loader
          type="article"
        />
      </v-col>
    </v-row>
    <v-row
      v-for="tag in displayTags"
      v-else
      :key="tag.id"
      class="mb-3"
      style="border-bottom: solid 1px #ccc;"
    >
      <v-col cols="12" class="pb-0">
        <nuxt-link
          :to="{ path: `/tags/${tag.id}` }"
          style="color: inherit; text-decoration: none;"
        >
          <v-card-text style="padding: 0">
            {{ tag.name }}
          </v-card-text>
        </nuxt-link>
      </v-col>
      <v-col cols="7">
        <v-row no-gutters>
          <v-col cols="12">
            <span class="font-weight-bold pr-2">
              フォロワー
            </span>
            {{ tag.users.length }}
          </v-col>
          <v-col cols="12">
            <span class="font-weight-bold pr-2">
              投稿
            </span>
            {{ tag.posts.length }}
          </v-col>
          <v-col cols="12">
            <span class="font-weight-bold pr-2">
              イベント
            </span>
            {{ tag.events.length }}
          </v-col>
        </v-row>
      </v-col>
      <v-col cols="5">
        <TagFollowBtnGroup
          :tag="tag"
          class="float-right"
        />
      </v-col>
    </v-row>
    <v-pagination
      v-model="page"
      color="info"
      :length="TagsLength"
      @input="pageChange"
    />
  </div>
</template>

<script>
import TagFollowBtnGroup from '~/components/molecles/tags/TagFollowBtnGroup'

export default {
  components: {
    TagFollowBtnGroup
  },
  props: {
    tags: {
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
      pageSize: 10
    }
  },
  computed: {
    displayTags () {
      return this.tags.slice(this.pageSize * (this.page - 1), this.pageSize * (this.page))
    },
    TagsLength () {
      return Math.ceil(this.tags.length / this.pageSize)
    }
  },
  methods: {
    pageChange (pageNumber) {
      this.displayTags.slice(this.pageSize * (pageNumber - 1), this.pageSize * (pageNumber))
    }
  }
}
</script>
