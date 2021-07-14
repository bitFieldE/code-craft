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
        メッセージを送る
      </v-btn>
    </template>
    <v-card>
      <v-banner class="grey lighten-5" style="height: 70px;" sticky outlined>
        <v-btn
          class="float-right"
          text
          @click="dialog = false"
        >
          <v-icon>
            mdi-close
          </v-icon>
        </v-btn>
      </v-banner>
      <ValidationObserver ref="form" v-slot="{ invalid }" immediate>
        <v-container>
          <v-form>
            <v-card-text class="pb-0">
              <TextAreaWithValidation
                v-model="content"
                label="メッセージ"
                rules="required"
                outlined
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
              @click="postEventComment"
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
    event: {
      type: Object,
      default: null
    }
  },
  data () {
    return {
      content: '',
      dialog: false,
      loading: false
    }
  },
  methods: {
    async postEventComment () {
      const isValid = await this.$refs.form.validate()
      const formData = new FormData()
      this.loading = true
      if (isValid) {
        formData.append('event_comment[user_id]', this.$auth.user.id)
        formData.append('event_comment[event_id]', this.event.id)
        formData.append('event_comment[content]', this.content)
        await this.$axios.$post('/api/v1/event_comments', formData)
          .then(
            (response) => {
              this.$store.commit('comments/addEventComments', response, { root: true })
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
