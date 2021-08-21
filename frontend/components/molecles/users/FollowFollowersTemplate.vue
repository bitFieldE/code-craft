<template>
  <v-container>
    <template v-if="loading">
      <v-row>
        <v-col
          v-for="n in 10"
          :key="n"
          cols="12"
          class="pb-0"
        >
          <v-skeleton-loader
            type="list-item-avatar, divider, list-item-three-line, actions"
          />
        </v-col>
      </v-row>
    </template>
    <template v-else-if="displayUsers.length > 0">
      <v-row
        v-for="user in displayUsers"
        :key="user.id"
        class="mb-3"
        style="border-bottom: solid 1px #ccc;"
      >
        <v-col cols="12" class="pb-0">
          <nuxt-link
            :to="{ path: `/users/${user.id}` }"
            style="color: inherit; text-decoration: none;"
          >
            <v-avatar
              v-if="user.image.url"
              color="white"
              size="35"
            >
              <v-img
                :src="user.image.url"
              />
            </v-avatar>
            <v-icon
              v-else
              size="40"
            >
              mdi-account-circle
            </v-icon>
            {{ user.name }}
          </nuxt-link>
        </v-col>
        <v-col cols="8">
          <v-card-text class="px-0">
            {{ user.description }}
          </v-card-text>
        </v-col>
        <v-col cols="4">
          <FollowBtnGroup
            v-if="user.id != $auth.user.id"
            :user="user"
            :followers="user.followers"
            class="float-right"
          />
        </v-col>
      </v-row>
      <v-pagination
        v-model="page"
        color="info"
        :length="UsersLength"
        @input="pageChange"
      />
    </template>
    <template v-else>
      <v-row>
        <v-col>
          <v-card>
            <v-card-text>
              ユーザーが存在しません
            </v-card-text>
          </v-card>
        </v-col>
      </v-row>
    </template>
  </v-container>
</template>

<script>
import FollowBtnGroup from '~/components/molecles/users/FollowBtnGroup'

export default {
  components: { FollowBtnGroup },
  props: {
    users: {
      type: Array,
      default: () => []
    }
  },
  data () {
    return {
      page: 1,
      length: 0,
      pageSize: 10,
      loading: false
    }
  },
  computed: {
    displayUsers () {
      return this.users.slice(this.pageSize * (this.page - 1), this.pageSize * (this.page))
    },
    UsersLength () {
      return Math.ceil(this.users.length / this.pageSize)
    }
  },
  mounted () {
    this.loading = true
    setTimeout(this.stopLoading, 500)
  },
  methods: {
    pageChange (pageNumber) {
      this.displayUsers.slice(this.pageSize * (pageNumber - 1), this.pageSize * (pageNumber))
    },
    stopLoading () {
      this.loading = false
    }
  }
}
</script>
