<template>
  <div>
    <TextFieldWithValidation
      v-model="keyword"
      prepend-icon="mdi-magnify"
      @keyup="searchTags"
    />
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
      <v-col cols="10">
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
      <v-col cols="2">
        <v-btn
          icon
          @click="deleteTag(tag.id)"
        >
          <v-icon>
            mdi-trash-can-outline
          </v-icon>
        </v-btn>
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
import TextFieldWithValidation from '~/components/atoms/input/TextFieldWithValidation'

export default {
  components: { TextFieldWithValidation },
  data () {
    return {
      page: 1,
      length: 0,
      pageSize: 10,
      loading: false,
      tags: [],
      keyword: ''
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
  async mounted () {
    this.loading = true
    await this.$axios.get('api/v1/admin/tags')
      .then((response) => {
        this.tags = response.data
      })
      .catch((error) => {
        return error
      })
    this.loading = false
  },
  methods: {
    async deleteTag (tagId) {
      if (window.confirm('削除してもよろしいですか？')) {
        await this.$axios.delete(`api/v1/tags/${tagId}/delete_tag`).then((response) => {
          this.tags = this.tags.filter(tag => tag.id !== tagId)
          this.$store.dispatch(
            'flash/showMessage',
            {
              message: response.data.message,
              color: 'primary',
              status: true
            },
            { root: true }
          )
        })
          .catch((error) => {
            return error
          })
      }
    },
    async searchTags () {
      this.loading = true
      await this.$axios.get('api/v1/admin/tags', {
        params: {
          keyword: this.keyword
        }
      }).then((response) => {
        this.tags = response.data
      })
        .catch((error) => {
          return error
        })
      this.loading = false
    },
    pageChange (pageNumber) {
      this.displayTags.slice(this.pageSize * (pageNumber - 1), this.pageSize * (pageNumber))
    }
  }
}
</script>
