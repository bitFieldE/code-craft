<template>
  <v-container>
    <v-row  align="center" justify="center">
      <v-col xs="12" sm="8" md="7" lg="6">
        <v-card>
          <v-tabs
            v-model="tab"
            fixed-tabs
            centered
            next-icon="mdi-arrow-right-bold-box-outline"
            prev-icon="mdi-arrow-left-bold-box-outline"
            show-arrows
            color="secondary"
            background-color="brown lighten-5"
          >
            <v-tab>
              ユーザー
            </v-tab>
            <v-tab>
              投稿
            </v-tab>
            <v-tab>
              イベント
            </v-tab>
          </v-tabs>
          <v-tabs-items v-model="tab" touchless>
            <v-tab-item>
            </v-tab-item>
            <v-tab-item>
            </v-tab-item>
            <v-tab-item>
              <v-container>
              </v-container>
            </v-tab-item>
          </v-tabs-items>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
export default {
  middleware: 'loginAuth',
  data () {
    return {
      tab: null
    }
  }
}
</script>
