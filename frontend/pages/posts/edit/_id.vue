<template>
  <v-container>
    <v-row justify="center">
      <v-col cols="11" xs="12" sm="12" md="11">
        <v-card>
          <ValidationObserver ref="form" v-slot="{ invalid }" immediate>
            <v-form ref="form">
              <v-container>
                <v-card-title>記事の詳細</v-card-title>
                <TextFieldWithValidation
                  v-model="title"
                  label="タイトル"
                  placeholder="記事のタイトル"
                  :counter="50"
                  rules="max:50|required"
                  outlined
                />
                <InputRate
                  v-model="rate"
                  rules="required|min_value:0.5"
                  half-increments
                  hover
                  large
                />
                <InputImages
                  v-model="images"
                  :value="post.images_data"
                />
                <InputContent
                  v-model="content"
                  label="本文"
                  rules="required"
                />
                <v-card-subtitle>タグを入力</v-card-subtitle>
                <InputTags
                  v-model="tags"
                />
                <v-card-text class="px-0">
                  <v-btn
                    color="warning"
                    class="white--text"
                    :disabled="invalid || loading"
                    :loading="loading"
                    block
                    @click="createPost"
                  >
                    作成する
                  </v-btn>
                </v-card-text>
              </v-container>
            </v-form>
          </ValidationObserver>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import { mapGetters } from 'vuex'
import TextFieldWithValidation from '~/components/atoms/input/TextFieldWithValidation'
import InputImages from '~/components/atoms/input/InputImages'
import InputRate from '~/components/atoms/input/InputRate'
import InputContent from '~/components/atoms/input/InputContent'
import InputTags from '~/components/atoms/input/InputTags'

export default {
  components: {
    TextFieldWithValidation,
    InputImages,
    InputRate,
    InputContent,
    InputTags
  },
  middleware: 'loginAuth',
  data () {
    return {
      title: '',
      content: '',
      rate: null,
      isEnter: false,
      loading: false,
      images: [],
      tags: []
    }
  },
  async fetch ({ $axios, params, store }) {
    await $axios.get(`api/v1/posts/${params.id}`)
      .then((response) => {
        store.commit('posts/setPost', response.data, { root: true })
      })
      .catch((error) => {
        console.log(error)
        return error
      })
  },
  mounted () {
    this.title = this.post.title
    this.rate = this.post.rate
    this.content = this.post.content
    this.post.tags.forEach((tag) => {
      this.tags.push(tag.name)
    })
  },
  computed: {
    ...mapGetters({ post: 'posts/post' })
  },
  methods: {
    async createPost () {
      const isValid = await this.$refs.form.validate()
      const formData = new FormData()
      this.loading = true

      if (isValid) {
        formData.append('post[title]', this.title)
        formData.append('post[rate]', this.rate)
        formData.append('post[content]', this.content)
        if (this.images) {
          this.images.forEach((image) => {
            formData.append('images[]', image)
          })
        }
        if (this.tags) {
          this.tags.forEach((tag) => {
            formData.append('post[tags][]', tag)
          })
        }
        await this.$axios.$patch(`/api/v1/posts/${this.post.id}`, formData)
          .then(
            (response) => {
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
              this.images = []
              this.$refs.form.reset()
              this.$router.push(`/posts/${response.post.id}`)
            },
            (error) => {
              this.$store.dispatch(
                'flash/showMessage',
                {
                  message: error,
                  color: 'error',
                  status: true
                },
                { root: true }
              )
              return error
            }
          )
        this.loading = false
      }
    }
  }
}
</script>
