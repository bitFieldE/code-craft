<template>
  <v-dialog
    v-model="dialog"
    persistent
    max-width="600"
  >
    <template #activator="{ on, attrs }">
      <v-btn
        v-bind="attrs"
        color="info"
        v-on="on"
      >
        <v-icon
          left
        >
          mdi-comment-outline
        </v-icon>
        コメントを投稿する
      </v-btn>
    </template>
    <v-card>
      <v-card-actions>
        <v-spacer />
        <v-btn
          text
          @click="dialog = false"
        >
          <v-icon>
            mdi-close
          </v-icon>
        </v-btn>
      </v-card-actions>
      <v-tabs
        v-model="tab"
        color="info"
        fixed-tabs
      >
        <v-tab
          v-for="(item, index) in items"
          :key="index"
        >
          {{ item.name }}
        </v-tab>
      </v-tabs>
      <ValidationObserver ref="form" v-slot="{ invalid }" immediate>
        <v-container>
          <v-form>
            <v-tabs-items
              v-model="tab"
            >
              <v-tab-item>
                <v-card-text class="pb-0">
                  <TextAreaWithValidation
                    v-model="content"
                    label="コメント"
                    rules="required"
                    outlined
                  />
                </v-card-text>
              </v-tab-item>
              <v-tab-item>
                <v-card-text
                  style="min-height: 200px;"
                  v-html="$md.render(content)"
                />
              </v-tab-item>
            </v-tabs-items>
          </v-form>
          <v-card-text>
            <v-btn
              :disabled="invalid || loading"
              :loading="loading"
              block
              color="warning"
              class="white--text"
              @click="postComment"
            >
              コメントする
            </v-btn>
          </v-card-text>
        </v-container>
      </ValidationObserver>
    </v-card>
  </v-dialog>
</template>

<script>
import TextAreaWithValidation from '~/components/atoms/input/TextAreaWithValidation'

export default {
  components: {
    TextAreaWithValidation
  },
  props: {
    post: {
      type: Object,
      default: null
    }
  },
  data () {
    return {
      content: '',
      dialog: false,
      loading: false,
      tab: null,
      items: [
        { name: '編集' },
        { name: 'プレビュー' }
      ]
    }
  },
  methods: {
    async postComment () {
      const isValid = await this.$refs.form.validate()
      const formData = new FormData()
      this.loading = true
      if (isValid) {
        formData.append('comment[user_id]', this.$auth.user.id)
        formData.append('comment[post_id]', this.post.id)
        formData.append('comment[content]', this.content)
        await this.$axios.$post('/api/v1/comments', formData)
          .then(
            (response) => {
              this.$store.commit('comments/addComments', response, { root: true })
              this.content = ''
              this.$refs.form.reset()
            },
            (error) => {
              return error
            }
          )
      }
      this.loading = false
      this.dialog = false
    }
  }
}
</script>
