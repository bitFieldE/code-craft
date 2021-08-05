<template>
  <v-dialog
    v-model="dialog"
    persistent
    max-width="600"
  >
    <template #activator="{ on, attrs }">
      <v-btn
        class="px-0"
        v-bind="attrs"
        text
        v-on="on"
      >
        フォロワー {{ followers.length }}
      </v-btn>
    </template>
    <v-card>
      <v-banner class="grey lighten-5" sticky outlined>
        <v-btn
          class="float-right"
          icon
          @click="dialog=false"
        >
          <v-icon>
            mdi-close
          </v-icon>
        </v-btn>
      </v-banner>
      <FollowFollowersTemplate
        :users="followers"
      />
    </v-card>
  </v-dialog>
</template>

<script>
import FollowFollowersTemplate from '~/components/molecles/users/FollowFollowersTemplate'
export default {
  components: { FollowFollowersTemplate },
  props: {
    followers: {
      type: Array,
      default: () => []
    }
  },
  data () {
    return {
      dialog: false
    }
  }
}
</script>
