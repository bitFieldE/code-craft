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
      loading: false,
      pageTitle: this.$t(`pages.${$route.name}`)
    }
  },
  methods: {
    async signup () {
      const isValid = await this.$refs.form.validate()
      const formData = new FormData()
      const authData = new FormData()
      this.loading = true

      if (isValid) {
        formData.append('user[name]', this.name)
        formData.append('user[email]', this.email)
        formData.append('user[password]', this.password)
        authData.append('auth[email]', this.email)
        authData.append('auth[password]', this.password)

        await this.$axios.$post('/api/v1/users', formData)
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
              this.$axios.$post('/api/v1/user_token', authData)
                .then(
                  (response) => {
                    this.$auth.login(response)
                  }
                )
              this.$router.push('/')
              return response
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
      this.params = { user: { name: '', email: '', password: '' } }
      this.$refs.form.reset()
    }
  }
}
</script>
