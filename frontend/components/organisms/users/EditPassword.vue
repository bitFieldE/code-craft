<template>
  <v-container>
    <ValidationObserver ref="form" v-slot="{ invalid }" immediate>
      <v-card-title>
        パスワード変更
      </v-card-title>
      <v-divider />
      <v-form class="pt-5">
        <TextFieldWithValidation
          v-model="current_password"
          label="現在のパスワード"
          autocomplete="on"
          vid="current_password"
          rules="required|alpha_dash|min:8|max:72"
          :type="show1 ? 'text' : 'password'"
          outlined
          :append-icon="show1 ? 'mdi-eye' : 'mdi-eye-off'"
          @click:append="show1 = !show1"
        />
        <TextFieldWithValidation
          v-model="password"
          label="新しいパスワード"
          name="password"
          autocomplete="on"
          vid="password"
          rules="required|alpha_dash|min:8|max:72"
          :type="show2 ? 'text' : 'password'"
          outlined
          :append-icon="show2 ? 'mdi-eye' : 'mdi-eye-off'"
          @click:append="show2 = !show2"
        />
        <TextFieldWithValidation
          v-model="password_confirmation"
          name="password_confirmation"
          label="パスワード確認"
          autocomplete="on"
          vid="password_confirmation"
          rules="required|alpha_dash|min:8|max:72|confirmed:password"
          :type="show3 ? 'text' : 'password'"
          outlined
          :append-icon="show3 ? 'mdi-eye' : 'mdi-eye-off'"
          @click:append="show3 = !show3"
        />
        <v-card-text class="px-0">
          <v-btn
            v-if="$auth.user.name=='guestuser'"
            disabled
            block
            color="warning"
            class="white--text"
            @click="updatePassword"
          >
            ゲストユーザーなので変更できまっせん
          </v-btn>
          <v-btn
            v-else
            :disabled="invalid || loading"
            :loading="loading"
            block
            color="warning"
            class="white--text"
            @click="updatePassword"
          >
            変更する
          </v-btn>
        </v-card-text>
      </v-form>
    </ValidationObserver>
  </v-container>
</template>

<script>
import TextFieldWithValidation from '~/components/atoms/input/TextFieldWithValidation'

export default {
  components: {
    TextFieldWithValidation
  },
  middleware: 'loginAuth',
  data () {
    return {
      loading: false,
      show1: false,
      show2: false,
      show3: false,
      current_password: '',
      password: '',
      password_confirmation: ''
    }
  },
  methods: {
    async updatePassword () {
      const formData = new FormData()
      const isValid = this.$refs.form.validate()
      this.loading = true

      if (isValid) {
        formData.append('user[current_password]', this.current_password)
        formData.append('user[password]', this.password)
        formData.append('user[password_confirmation]', this.password_confirmation)
        await this.$axios.$patch('/api/v1/passwords', formData)
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
              this.$refs.form.reset()
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
