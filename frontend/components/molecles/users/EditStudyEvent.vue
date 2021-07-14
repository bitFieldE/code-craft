<template>
  <v-dialog
    v-model="dialog"
    persistent
    max-width="700"
  >
    <template #activator="{ on, attrs }">
      <v-btn
        v-bind="attrs"
        class="white--text"
        color="lime accent-4"
        small
        fab
        v-on="on"
      >
        <v-icon>
          mdi-clipboard-edit-outline
        </v-icon>
      </v-btn>
    </template>
    <v-card>
      <v-banner class="grey lighten-5" sticky outlined>
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
            <v-card-text>
              <InputEventImage
                v-model="image"
                :event_image="event.image_url"
              />
            </v-card-text>
            <v-card-text>
              <TextFieldWithValidation
                v-model="title"
                label="イベントのタイトル"
                rules="required"
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
            <v-card-text class="pb-0">
              <TextAreaWithValidation
                v-model="content"
                label="詳細"
                rules="required|max:1000"
                outlined
              />
            </v-card-text>
            <v-card-text>
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
              編集する
            </v-btn>
          </v-card-text>
        </v-container>
      </ValidationObserver>
    </v-card>
  </v-dialog>
</template>

<script>
import AutoCompleteWithValidation from '~/components/atoms/input/AutoCompleteWithValidation'
import DatePicker from '~/components/atoms/input/DatePicker'
import InputEventImage from '~/components/atoms/input/InputEventImage'
import TextAreaWithValidation from '~/components/atoms/input/TextAreaWithValidation'
import TextFieldWithValidation from '~/components/atoms/input/TextFieldWithValidation'
import InputTags from '~/components/atoms/input/InputTags.vue'

export default {
  components: {
    AutoCompleteWithValidation,
    DatePicker,
    InputEventImage,
    TextAreaWithValidation,
    TextFieldWithValidation,
    InputTags
  },
  props: {
    post: {
      type: Object,
      default: null
    },
    event: {
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
      scheduled_date: '',
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
  mounted () {
    this.image = ''
    this.title = this.event.title
    this.content = this.event.content
    this.place = this.event.place
    this.participant_number = this.event.participant_number
    this.scheduled_date = this.event.scheduled_date
    this.start_time = this.$moment(this.event.start_time).format('HH:mm')
    this.end_time = this.$moment(this.event.end_time).format('HH:mm')
    this.event.tags.forEach((tag) => {
      this.tags.push(tag.name)
    })
  },
  methods: {
    async createEvent () {
      const isValid = await this.$refs.form.validate()
      const formData = new FormData()
      this.loading = true
      if (isValid) {
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
        await this.$axios.$patch(`/api/v1/events/${this.event.id}`, formData)
          .then(
            (response) => {
              console.log(response)
              this.$store.commit('events/updateEvent', response, { root: true })
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
