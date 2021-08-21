<template>
  <div>
    <TextFieldWithValidation
      v-model="keyword"
      prepend-icon="mdi-magnify"
      @keyup="searchUsers"
    />
    <v-row v-if="loading">
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
    <v-row
      v-for="user in displayUsers"
      v-else
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
      <v-col cols="10">
        <v-card-text class="px-0">
          {{ user.description }}
        </v-card-text>
      </v-col>
      <v-col cols="2">
        <v-btn
          color="error"
          small
          rounded
          right
          @click="deleteUser(user.id)"
        >
          削除
        </v-btn>
      </v-col>
    </v-row>
    <v-pagination
      v-model="page"
      color="info"
      :length="UsersLength"
      @input="pageChange"
    />
  </div>
</template>

<script>
import TextFieldWithValidation from '~/components/atoms/input/TextFieldWithValidation'

export default {
  components: {
    TextFieldWithValidation
  },
  data () {
    return {
      page: 1,
      length: 0,
      pageSize: 10,
      loading: false,
      users: [],
      keyword: ''
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
  async mounted () {
    this.loading = true
    await this.$axios.get('api/v1/admin/users')
      .then((response) => {
        this.users = response.data
      })
      .catch((error) => {
        return error
      })
    this.loading = false
  },
  methods: {
    async deleteUser (userId) {
      if (window.confirm('削除してもよろしいですか？')) {
        await this.$axios.delete(`api/v1/users/${userId}`).then((response) => {
          this.users = this.users.filter(user => user.id !== userId)
        })
          .catch((error) => {
            return error
          })
      }
    },
    async searchUsers () {
      this.loading = true
      await this.$axios.get('api/v1/admin/users', {
        params: {
          keyword: this.keyword
        }
      }).then((response) => {
        this.users = response.data
      })
        .catch((error) => {
          return error
        })
      this.loading = false
    },
    pageChange (pageNumber) {
      this.displayUsers.slice(this.pageSize * (pageNumber - 1), this.pageSize * (pageNumber))
    }
  }
}
</script>
