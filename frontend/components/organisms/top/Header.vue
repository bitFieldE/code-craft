<template>
  <v-app-bar
    app
    dense
    dark
  >
    <v-menu
      bottom
      nudge-left="110"
      nudge-width="100"
    >
      <template #activator="{ on }">
        <v-app-bar-nav-icon
          class="d-flex d-sm-none"
          v-on="on"
        />
      </template>
      <v-list
        dense
      >
        <v-list-item
          v-for="(menu, i) in menus"
          :key="`menu-list-${i}`"
          exact
          :to="menu.to"
        >
          <v-list-item-title>
            {{ $t(`menus.${menu.title}`) }}
          </v-list-item-title>
        </v-list-item>
      </v-list>
    </v-menu>
    <v-toolbar-title>
      CodeCraft
    </v-toolbar-title>
    <v-spacer />
    <v-toolbar-items class="ml-2 d-xs-none d-none d-sm-flex">
      <v-btn
        v-for="(menu, i) in menus"
        :key="`menu-btn-${i}`"
        :to="`${menu.to}`"
        text
      >
        {{ $t(`menus.${menu.title}`) }}
      </v-btn>
    </v-toolbar-items>
    <template v-if="!$auth.isUserPresent()">
      <signup-button />
      <login-button />
    </template>
    <template v-else>
      <LoginBar />
    </template>
  </v-app-bar>
</template>

<script>
import LoginBar from '~/components/molecles/top/LoginBar'
import LoginButton from '~/components/atoms/top/LoginButton.vue'
import SignupButton from '~/components/atoms/top/SignupButton.vue'

export default {
  components: {
    LoginBar,
    LoginButton,
    SignupButton
  },
  data () {
    return {
      menus: [
        {
          title: 'home',
          to: '/'
        },
        {
          title: 'about',
          to: '/about'
        }
      ]
    }
  }
}
</script>
