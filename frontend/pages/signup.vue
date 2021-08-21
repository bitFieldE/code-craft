<template>
  <FormTemplate>
    <template #form-card-content>
      <ValidationObserver ref="form" v-slot="{ invalid }" immediate>
        <v-form>
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
          <TextFieldWithValidation
            v-model="password"
            label="パスワード"
            autocomplete="on"
            vid="password"
            rules="required|alpha_dash|min:8|max:72"
            :type="show ? 'text' : 'password'"
            outlined
            :append-icon="show ? 'mdi-eye' : 'mdi-eye-off'"
            @click:append="show = !show"
          />
          <TextFieldWithValidation
            v-model="password_confirmation"
            label="パスワード確認"
            autocomplete="on"
            vid="password_confirmation"
            rules="required|alpha_dash|min:8|max:72"
            :type="show ? 'text' : 'password'"
            outlined
            :append-icon="show ? 'mdi-eye' : 'mdi-eye-off'"
            @click:append="show = !show"
          />
          <v-card-text class="px-0">
            <v-btn
              :disabled="invalid || loading"
              :loading="loading"
              block
              color="warning"
              class="white--text"
              @click="signup"
            >
              登録する
            </v-btn>
          </v-card-text>
          <v-divider />
          <v-card-text class="pb-8">
            <span>すでにアカウントをお持ちですか？</span>
            <nuxt-link to="/login">
              ログインに移動
            </nuxt-link>
          </v-card-text>
        </v-form>
      </ValidationObserver>
    </template>
  </FormTemplate>
</template>

<script>
import TextFieldWithValidation from '~/components/atoms/input/TextFieldWithValidation'
import FormTemplate from '~/components/organisms/top/FormTemplate'

export default {
  components: {
    TextFieldWithValidation,
    FormTemplate
  },
  middleware: 'authenticated',
  data ({ $route }) {
    return {
      show: false,
      name: '',
      email: '',
      password: '',
      password_confirmation: '',
      loading: false,
      pageTitle: this.$t(`pages.${$route.name}`)
    }
  },
  methods: {
    async signup () {
      const isValid = await this.$refs.form.validate()
      const formData = new FormData()
      this.loading = true

      if (isValid) {
        formData.append('name', this.name)
        formData.append('email', this.email)
        formData.append('password', this.password)
        formData.append('password_confirmation', this.password_confirmation)

        await this.$axios.$post('/api/v1/auth', formData, {
          headers: {
            'Content-Type': 'multipart/form-data'
          }
        })
          .then(
            (response) => {
              this.$store.dispatch(
                'flash/showMessage',
                {
                  message: 'ユーザーを登録しました',
                  color: 'success',
                  status: true
                },
                { root: true }
              )
              console.log(response.data)
              this.$auth.login(response.data)
              this.$router.push('/')
            },
            (error) => {
              this.$store.dispatch(
                'flash/showMessage',
                {
                  message: '登録に失敗しました',
                  color: 'error',
                  status: true
                },
                { root: true }
              )
              return error
            }
          )
      }
      setTimeout(() => {
        this.formReset()
      }, 1500)
      this.loading = false
    },
    formReset () {
      this.params = { name: '', email: '', password: '', password_confirmation: '' }
      this.$refs.form.reset()
    }
  }
}
</script>
