<template>
  <v-container>
    <v-row align="center" justify="center">
      <v-col xs="12" sm="8" md="7" lg="6">
        <v-card>
          <v-tabs
            v-model="tab"
            fixed-tabs
            centered
            show-arrows
            color="secondary"
            background-color="brown lighten-5"
          >
            <v-tab>
              <v-icon>
                mdi-account
              </v-icon>
            </v-tab>
            <v-tab>
              <v-icon>
                mdi-notebook
              </v-icon>
            </v-tab>
            <v-tab>
              <v-icon>
                mdi-calendar-clock
              </v-icon>
            </v-tab>
            <v-tab>
              <v-icon>
                mdi-tag
              </v-icon>
            </v-tab>
          </v-tabs>
          <v-tabs-items v-model="tab" touchless>
            <v-tab-item>
              <v-container>
                <SearchUsers />
              </v-container>
            </v-tab-item>
            <v-tab-item>
              <v-container>
                <SearchPosts />
              </v-container>
            </v-tab-item>
            <v-tab-item>
              <v-container>
                <SearchEvents />
              </v-container>
            </v-tab-item>
            <v-tab-item>
              <v-container>
                <SearchTags />
              </v-container>
            </v-tab-item>
          </v-tabs-items>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import SearchEvents from '~/components/organisms/top/SearchEvents'
import SearchPosts from '~/components/organisms/top/SearchPosts'
import SearchTags from '~/components/organisms/top/SearchTags'
import SearchUsers from '~/components/organisms/top/SearchUsers'

export default {
  components: {
    SearchEvents,
    SearchPosts,
    SearchTags,
    SearchUsers
  },
  middleware: 'loginAuth',
  data () {
    return {
      tab: null
    }
  }
}
</script>
