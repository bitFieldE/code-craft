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
        small
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
      <v-banner
        class="grey lighten-5"
        sticky
        outlined
      >
        <v-btn
          class="float-right my-0"
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
            <v-card-text>
              <InputEventImage
                v-model="image"
              />
            </v-card-text>
            <v-card-text>
              <TextFieldWithValidation
                v-model="title"
                label="イベントのタイトル"
                rules="required|max:50"
                outlined
              />
            </v-card-text>
            <v-card-text>
              <DatePicker
                v-model="scheduled_date"
              />
            </v-card-text>
            <v-row>
              <v-col
                cols="12"
                xs="6"
                sm="5"
                md="5"
              >
                <v-card-text>
                  <TextFieldWithValidation
                    v-model="start_time"
                    type="time"
                    label="開始時間"
                    rules="required"
                  />
                </v-card-text>
              </v-col>
              <v-col
                cols="12"
                xs="6"
                sm="5"
                md="5"
              >
                <v-card-text>
                  <TextFieldWithValidation
                    v-model="end_time"
                    type="time"
                    label="終了時間"
                    rules="required"
                  />
                </v-card-text>
              </v-col>
              <v-col
                cols="6"
              >
                <v-card-text>
                  <AutoCompleteWithValidation
                    v-model="participant_number"
                    label="人数"
                    rules="required"
                  />
                </v-card-text>
              </v-col>
            </v-row>
            <v-card-text>
              <TextFieldWithValidation
                v-model="place"
                label="イベントの開催場所"
                placeholder="例: Zoom/Whereby/場所"
                rules="required"
                outlined
              />
            </v-card-text>
            <v-card-text>
              <TextAreaWithValidation
                v-model="content"
                label="詳細"
                rules="required|max:1000"
                outlined
              />
            </v-card-text>
            <v-card-text class="pb-0">
              <v-card-subtitle>タグを入力</v-card-subtitle>
              <InputTags
                v-model="tags"
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
              @click="createEvent"
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
import DatePicker from '~/components/atoms/input/DatePicker'
import InputEventImage from '~/components/atoms/input/InputEventImage'
import TextAreaWithValidation from '~/components/atoms/input/TextAreaWithValidation'
import TextFieldWithValidation from '~/components/atoms/input/TextFieldWithValidation'
import AutoCompleteWithValidation from '~/components/atoms/input/AutoCompleteWithValidation'
import InputTags from '~/components/atoms/input/InputTags'

export default {
  components: {
    DatePicker,
    InputEventImage,
    TextAreaWithValidation,
    TextFieldWithValidation,
    AutoCompleteWithValidation,
    InputTags
  },
  props: {
    user: {
      type: Object,
      default: null
    },
    post: {
      type: Object,
      default: null
    }
  },
  data () {
    return {
      image: null,
      title: '',
      content: '',
      place: '',
      participant_number: null,
      scheduled_date: new Date().toLocaleDateString().replace(/\//g, '-'),
      start_time: '',
      end_time: '',
      tags: [],
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
    async createEvent () {
      const isValid = await this.$refs.form.validate()
      const formData = new FormData()
      this.loading = true
      if (isValid) {
        console.log(this.post.id)
        formData.append('event[user_id]', this.$auth.user.id)
        formData.append('event[post_id]', this.post.id)
        if (this.image) { formData.append('event[image]', this.image) }
        formData.append('event[title]', this.title)
        formData.append('event[participant_number]', this.participant_number)
        formData.append('event[place]', this.place)
        formData.append('event[content]', this.content)
        formData.append('event[scheduled_date]', this.scheduled_date)
        formData.append('event[start_time]', this.start_time)
        formData.append('event[end_time]', this.end_time)
        if (this.tags) {
          this.tags.forEach((tag) => {
            formData.append('event[tags][]', tag)
          })
        }
        await this.$axios.$post('/api/v1/events', formData)
          .then(
            (response) => {
              if (response.event.user.id === this.user.id) {
                this.$store.commit('events/addEvent', response.event, { root: true })
              }
              this.$store.dispatch(
                'flash/showMessage',
                {
                  message: response.message,
                  color: 'success',
                  status: true
                },
                { root: true }
              )
              this.title = ''
              this.content = ''
              this.place = ''
              this.participant_number = null
              this.scheduled_date = new Date().toLocaleDateString().replace(/\//g, '-')
              this.start_time = ''
              this.end_time = ''
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
