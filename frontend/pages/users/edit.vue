<template>
  <v-container class="col-xs-12 col-sm-8 col-md-6">
    <v-card>
      <v-tabs
        v-model="tab"
        fixed-tabs
        centered
        color="info"
        background-color="greyLight4"
      >
        <v-tab>
          <v-icon>mdi-account-edit</v-icon>
          プロフィール
        </v-tab>
        <v-tab>
          <v-icon>mdi-account-lock</v-icon>
          パスワード
        </v-tab>
      </v-tabs>
      <v-tabs-items v-model="tab" touchless>
        <v-tab-item>
          <editUser />
        </v-tab-item>
        <v-tab-item>
          <v-container>
            <editPassword />
          </v-container>
        </v-tab-item>
      </v-tabs-items>
    </v-card>
    <v-card-text>
      <v-btn
        color="secondary"
        @click="deleteUser"
      >
        退会する
      </v-btn>
    </v-card-text>
  </v-container>
</template>

<script>
import editUser from '~/components/template/users/editUser'
import editPassword from '~/components/template/users/editPassword'

export default {
  components: {
    editUser,
    editPassword
  },
  middleware: 'loginAuth',
  data () {
    return {
      tab: null
    }
  },
  methods: {
    async deleteUser () {
      if (window.confirm('退会してもよろしいですか？')) {
        await this.$axios.$delete(`/api/v1/users/${this.$auth.user.id}`)
          .then(
            (response) => {
              this.$auth.logout()
              this.$store.dispatch(
                'flash/showMessage',
                {
                  message: response.message,
                  color: 'success',
                  status: true
                },
                { root: true }
              )
              this.$router.push('/')
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
      }
    }
  }
}
</script>
