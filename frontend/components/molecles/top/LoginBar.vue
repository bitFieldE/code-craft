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
        <v-avatar v-if="$auth.user.image.url" color="white" size="34">
          <v-img :src="$auth.user.image.url" />
        </v-avatar>
        <v-icon v-else size="34">
          mdi-account-circle
        </v-icon>
      </v-btn>
    </template>
    <v-list dense>
      <v-subheader>
        ログイン中のユーザー
      </v-subheader>

      <v-list-item>
        <v-list-item-content>
          <v-list-item-title>
            {{ $auth.user.name }}
          </v-list-item-title>
        </v-list-item-content>
      </v-list-item>

      <v-divider />

      <v-subheader>
        アカウント
      </v-subheader>

      <v-list-item
        v-if="$auth.user.admin"
        :to="{ path: '/admin' }"
      >
        <v-list-item-icon class="mr-2">
          <v-icon size="22">
            mdi-card-account-details-star
          </v-icon>
        </v-list-item-icon>
        <v-list-item-title>
          管理者専用ページ
        </v-list-item-title>
      </v-list-item>
      <v-list-item :to="{ path: '/search' }">
        <v-list-item-icon class="mr-2">
          <v-icon size="22">
            mdi-magnify
          </v-icon>
        </v-list-item-icon>
        <v-list-item-title>
          検索
        </v-list-item-title>
      </v-list-item>
      <v-list-item :to="{ path: `/users/${$auth.user.id}` }">
        <v-list-item-icon class="mr-2">
          <v-icon size="22">
            mdi-account
          </v-icon>
        </v-list-item-icon>
        <v-list-item-title>
          プロフィール詳細
        </v-list-item-title>
      </v-list-item>
      <v-list-item
        :to="{ path: '/users/edit' }"
      >
        <v-list-item-icon class="mr-2">
          <v-icon size="22">
            mdi-account-cog
          </v-icon>
        </v-list-item-icon>
        <v-list-item-title>
          プロフィール編集
        </v-list-item-title>
      </v-list-item>
      <v-list-item @click="logout">
        <v-list-item-icon class="mr-2">
          <v-icon size="22">
            mdi-logout-variant
          </v-icon>
        </v-list-item-icon>
        <v-list-item-title>
          ログアウト
        </v-list-item-title>
      </v-list-item>
    </v-list>
  </v-menu>
</template>

<script>
export default {
  methods: {
    async logout () {
      await this.$auth.logout()
      this.$store.dispatch(
        'flash/showMessage',
        {
          message: 'ログアウトしました',
          color: 'success',
          status: true
        },
        { root: true }
      )
      this.$router.push('/')
    }
  }
}
</script>
