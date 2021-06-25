<template>
  <v-dialog
    v-model="dialog"
    persistent
    max-width="700"
  >
    <template #activator="{ on, attrs }">
      <v-btn
        v-bind="attrs"
        color="warning"
        class="float-right"
        v-on="on"
      >
        <v-icon
          left
        >
          mdi-calendar-month-outline
        </v-icon>
        イベント作成
      </v-btn>
    </template>
    <v-card>
      <v-card-actions style="background-color: #F5F5F5">
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
      <ValidationObserver ref="form" v-slot="{ invalid }" immediate>
        <v-container>
          <v-form>
            <v-card-text>
              <DatePickerWithValidation />
            </v-card-text>
            <v-card-text class="pb-0">
              <TextAreaWithValidation
                v-model="content"
                label="詳細"
                rules="required|max:1000"
              />
            </v-card-text>
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
              作成する
            </v-btn>
          </v-card-text>
        </v-container>
      </ValidationObserver>
    </v-card>
  </v-dialog>
</template>

<script>
import TextAreaWithValidation from '~/components/atoms/input/TextAreaWithValidation'
import DatePickerWithValidation from '~/components/atoms/input/DatePickerWithValidation'

export default {
  components: {
    TextAreaWithValidation,
    DatePickerWithValidation 
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
      eventDate: new Date().toLocaleDateString().replace(/\//g, '-'),
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
