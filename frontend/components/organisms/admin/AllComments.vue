<template>
  <div>
    <TextFieldWithValidation
      v-model="keyword"
      prepend-icon="mdi-magnify"
      @keyup="searchComments"
    />
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
        v-for="comment in displayComments"
        :key="comment.id"
        class="mb-4"
      >
        <v-container>
          <v-card-actions>
            <v-avatar
              v-if="comment.user.image_url"
              color="black"
              size="40"
              class="mr-1"
            >
              <v-img
                :src="comment.user.image_url"
              />
            </v-avatar>
            <v-icon
              v-else
              size="40"
            >
              mdi-account-circle
            </v-icon>
            <span class="pl-2">
              {{ comment.user.name }}
            </span>
          </v-card-actions>
          <v-card-text v-html="$md.render(comment.content)" />
          <v-card-subtitle class="pb-0">
            {{ $moment(comment.created_at).format('YYYY/MM/DD HH:MM') }}
            <v-btn icon>
              <v-icon
                size="20"
                @click="deleteComment(comment.id)"
              >
                mdi-trash-can-outline
              </v-icon>
            </v-btn>
          </v-card-subtitle>
        </v-container>
      </v-card>
    </template>
    <v-pagination
      v-if="comments.length > 10"
      v-model="page"
      color="info"
      :length="CommentsLength"
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
      comments: [],
      keyword: ''
    }
  },
  async mounted () {
    this.loading = true
    await this.$axios.get('api/v1/admin/comments')
      .then((response) => {
        this.comments = response.data
      })
      .catch((error) => {
        return error
      })
    this.loading = false
  },
  computed: {
    displayComments () {
      return this.comments.slice(this.pageSize * (this.page - 1), this.pageSize * (this.page))
    },
    CommentsLength () {
      return Math.ceil(this.comments.length / this.pageSize)
    }
  },
  methods: {
    async searchComments () {
      this.loading = true
      await this.$axios.get('api/v1/admin/comments', {
        params: {
          keyword: this.keyword
        }
      }).then((response) => {
        this.comments = response.data
      })
        .catch((error) => {
          return error
        })
      this.loading = false
    },
    async deleteComment (commentId) {
      await this.$axios.$delete(`/api/v1/comments/${commentId}`)
        .then(
          (response) => {
            this.comments = this.comments.filter(comment => comment.id !== commentId)
          },
          (error) => {
            return error
          }
        )
    }
  },
  pageChange (pageNumber) {
    this.displayComments.slice(this.pageSize * (pageNumber - 1), this.pageSize * (pageNumber))
  }
}
</script>
