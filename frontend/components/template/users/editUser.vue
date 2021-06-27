<template>
  <v-container>
    <ValidationObserver ref="form" v-slot="{ invalid }" immediate>
      <v-card-title>
        基本情報
      </v-card-title>
      <v-divider />
      <v-form>
        <ImageFileWithValidation
          v-model="image"
          rules="mimes:image/*|ext:jpeg,jpg,png"
          label="プロフィール画像"
        />
        <TextFieldWithValidation
          v-model="name"
          label="ユーザー名"
          placeholder="あなたの表示名"
          :counter="15"
          rules="max:15|required"
          outlined
        />
        <TextFieldWithValidation
          v-model="email"
          label="メールアドレス"
          rules="required|email|max:30"
          outlined
        />
        <TextAreaWithValidation
          v-model="description"
          label="自己紹介"
          rules="max:1000"
          :counter="1000"
          outlined
        />
        <v-divider />
        <v-card-subtitle>
          興味のある技術
        </v-card-subtitle>
        <InputTags
          v-model="tags"
        />
        <v-card-text class="px-0">
          <v-btn
            :disabled="invalid || loading"
            :loading="loading"
            block
            color="warning"
            class="white--text"
            @click="updateProfile"
          >
            保存する
          </v-btn>
        </v-card-text>
      </v-form>
    </ValidationObserver>
  </v-container>
</template>

<script>
import TextFieldWithValidation from '~/components/atoms/input/TextFieldWithValidation'
import TextAreaWithValidation from '~/components/atoms/input/TextAreaWithValidation'
import ImageFileWithValidation from '~/components/atoms/input/ImageFileWithValidation'
import InputTags from '~/components/atoms/input/InputTags'

export default {
  components: {
    TextFieldWithValidation,
    TextAreaWithValidation,
    ImageFileWithValidation,
    InputTags
  },
  data () {
    return {
      loading: false,
      image: null,
      name: this.$auth.user.name,
      email: this.$auth.user.email,
      description: this.$auth.user.description,
      tags: []
    }
  },
  mounted () {
    this.$auth.user.tags.forEach((tag) => {
      this.tags.push(tag.name)
    })
  },
  methods: {
    async updateProfile () {
      const isValid = await this.$refs.form.validate()
      const formData = new FormData()
      this.loading = true

      if (isValid) {
        if (this.image) { formData.append('user[image]', this.image) }
        if (this.tags) {
          this.tags.forEach((tag) => {
            formData.append('user[tags][]', tag)
          })
        }
        formData.append('user[name]', this.name)
        formData.append('user[email]', this.email)
        formData.append('user[description]', this.description)
        this.loading = true
        await this.$axios.$patch(`/api/v1/users/${this.$auth.user.id}`, formData)
          .then(
            (response) => {
              this.$store.dispatch('getCurrentUser', response)
              this.$store.dispatch(
                'flash/showMessage',
                {
                  message: 'ユーザー情報を更新しました',
                  color: 'success',
                  status: true
                },
                { root: true }
              )
            },
            (error) => {
              this.$store.dispatch(
                'flash/showMessage',
                {
                  message: '更新に失敗しました',
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
