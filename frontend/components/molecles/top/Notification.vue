<template>
  <v-menu
    app
    offset-x
    offset-y
    max-width="300"
  >
    <template #activator="{ on }">
      <v-btn
        icon
        v-on="on"
      >
        <v-icon size="25">
          mdi-bell-outline
        </v-icon>
      </v-btn>
    </template>
    <v-list dense>
      <v-subheader>
        通知
      </v-subheader>

      <v-list-item>
        <v-list-item-content>
          <v-list-item-title>
            {{ $auth.user.name }}
          </v-list-item-title>
        </v-list-item-content>
      </v-list-item>
    </v-list>
  </v-menu>
</template>

<script>
export default {
  methods: {
    async logout () {
      await this.$auth.logout()
      await this.$store.dispatch(
        'flash/showMessage',
        {
          message: 'ログアウトしました',
          color: 'success',
          status: true
        },
        { root: true }
      )
      await this.$router.push('/')
    }
  }
}
</script>
