<template>
  <v-container>
    <v-row justify="center">
      <v-col
        class="d-none d-sm-inline"
        sm="4"
        md="4"
        lg="4"
      >
        <v-card>
          <v-tabs
            v-model="tab"
            vertical
            color="secondary"
          >
            <v-tab>
              <v-icon left>
                mdi-account
              </v-icon>
              ユーザー
            </v-tab>
            <v-tab>
              <v-icon left>
                mdi-notebook
              </v-icon>
              レビュー記事
            </v-tab>
            <v-tab>
              <v-icon left>
                mdi-calendar-clock
              </v-icon>
              イベント
            </v-tab>
            <v-tab>
              <v-icon left>
                mdi-tag
              </v-icon>
              タグ
            </v-tab>
            <v-tab>
              <v-icon left>
                mdi-comment-text
              </v-icon>
              記事へのコメント
            </v-tab>
            <v-tab>
              <v-icon left>
                mdi-comment-multiple-outline
              </v-icon>
              イベントのコメント
            </v-tab>
          </v-tabs>
        </v-card>
      </v-col>
      <v-col xs="12" sm="8" md="8" lg="8">
        <v-card>
          <v-tabs
            v-model="tab"
            class="d-inline d-sm-none py-0"
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
            <v-tab>
              <v-icon>
                mdi-comment-text
              </v-icon>
            </v-tab>
            <v-tab>
              <v-icon>
                mdi-comment-multiple-outline
              </v-icon>
            </v-tab>
          </v-tabs>
          <v-tabs-items v-model="tab" touchless>
            <v-tab-item>
              <v-container>
                <AllUsers />
              </v-container>
            </v-tab-item>
            <v-tab-item>
              <v-container>
                <AllPosts />
              </v-container>
            </v-tab-item>
            <v-tab-item>
              <v-container>
                <AllEvents />
              </v-container>
            </v-tab-item>
            <v-tab-item>
              <v-container>
                <AllTags />
              </v-container>
            </v-tab-item>
            <v-tab-item>
              <v-container>
                <AllComments />
              </v-container>
            </v-tab-item>
            <v-tab-item>
              <v-container>
                <AllEventComments />
              </v-container>
            </v-tab-item>
          </v-tabs-items>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import AllEvents from '~/components/organisms/admin/AllEvents'
import AllPosts from '~/components/organisms/admin/AllPosts'
import AllUsers from '~/components/organisms/admin/AllUsers'
import AllTags from '~/components/organisms/admin/AllTags'
import AllComments from '~/components/organisms/admin/AllComments'
import AllEventComments from '~/components/organisms/admin/AllEventComments'

export default {
  components: {
    AllEvents,
    AllPosts,
    AllUsers,
    AllTags,
    AllComments,
    AllEventComments
  },
  middleware: 'loginAuth',
  data () {
    return {
      tab: null
    }
  },
  mounted () {
    if (!this.$auth.user.admin) {
      this.$router.push('/')
    }
  }
}
</script>
