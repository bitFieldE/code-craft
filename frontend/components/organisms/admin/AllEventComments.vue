<template>
  <div>
    <TextFieldWithValidation
      v-model="keyword"
      prepend-icon="mdi-magnify"
      @keyup="searchEventComments"
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
        v-for="comment in comments"
        :key="comment.id"
        class="mb-4"
      >
        <v-container>
          <v-card-actions>
            <v-avatar
              v-if="comment.user.image.url"
              color="black"
              size="40"
              class="mr-1"
            >
              <v-img
                :src="comment.user.image.url"
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
      pageSize: 5,
      loading: false,
      comments: [],
      keyword: ''
    }
  },
  async mounted () {
    this.loading = true
    await this.$axios.get('api/v1/admin/event_comments')
      .then((response) => {
        this.comments = response.data
      })
      .catch((error) => {
        return error
      })
    this.loading = false
  },
  methods: {
    async searchEventComments () {
      this.loading = true
      await this.$axios.get('api/v1/admin/event_comments', {
        params: {
          keyword: this.keyword
        }
      }).then((response) => {
        console.log(this.comments)
        this.comments = response.data
      })
        .catch((error) => {
          return error
        })
      this.loading = false
    },
    async deleteComment (commentId) {
      await this.$axios.$delete(`/api/v1/event_comments/${commentId}`)
        .then(
          (response) => {
            this.comments = this.comments.filter(comment => comment.id !== commentId)
          },
          (error) => {
            return error
          }
        )
    }
  }
}
</script>
