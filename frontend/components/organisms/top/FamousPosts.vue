<template>
  <v-container>
    <v-row v-if="loading">
      <v-col
        v-for="n in 6"
        :key="n"
        xs="12"
        sm="6"
        md="６"
        cols="12"
      >
        <v-skeleton-loader
          type="article, actions"
        />
      </v-col>
    </v-row>
    <v-row v-else>
      <v-col
        v-for="post in posts"
        :key="post.id"
        xs="12"
        sm="6"
        md="６"
        cols="12"
      >
        <v-card>
          <nuxt-link
            :to="{ path: `/posts/${post.id}` }"
            style="color: inherit; text-decoration: none;"
          >
            <v-card-subtitle class="pb-0">
              {{ $moment(post.created_at).format('YYYY/MM/DD HH:MM') }}
            </v-card-subtitle>
            <v-card-title>
              {{ post.title }}
            </v-card-title>
            <v-card-actions class="ml-2">
              <v-rating
                :value="post.rate"
                color="yellow darken-3"
                background-color="grey darken-1"
                readonly
                half-increments
                dense
                small
              />
              <span class="rate pl-1">
                ({{ post.rate }})
              </span>
            </v-card-actions>
          </nuxt-link>
          <v-card-text
            v-if="post.tags.length > 0"
            class="py-0"
          >
            <v-chip-group
              class="w-100"
              active-class="primary--text"
              column
            >
              <v-chip
                v-for="tag in post.tags"
                :key="tag.id"
                color="info"
                outlined
                small
              >
                <nuxt-link
                  :to="{ path: `/tags/${tag.id}` }"
                  style="color: inherit; text-decoration: none;"
                >
                  {{ tag.name }}
                </nuxt-link>
              </v-chip>
            </v-chip-group>
          </v-card-text>
          <nuxt-link
            :to="{ path: `/users/${post.user.id}` }"
            style="color: inherit; text-decoration: none;"
          >
            <v-card-text>
              <v-avatar
                v-if="post.user.image_url"
                size="20"
              >
                <v-img
                  :src="post.user.image_url"
                />
              </v-avatar>
              <v-icon
                v-else
              >
                mdi-account-circle
              </v-icon>
              {{ post.user.name }}
            </v-card-text>
          </nuxt-link>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
export default {
  props: {
    posts: {
      type: Array,
      default: () => []
    },
    loading: {
      type: Boolean,
      default: null
    }
  }
}
</script>
