<template>
  <div>
    <v-img
      dark
      src="images/top_img.jpg"
      gradient="to top right, rgba(201, 214, 255, .6), rgba(226, 226, 226, .9)"
      :height="imgHeight"
    >
      <v-row
        align="center"
        justify="center"
        :style="{ height: `${imgHeight}px` }"
      >
        <v-col
          cols="12"
          class="text-center"
        >
          <h1
            class="display-1 mb-4"
            :style="{ letterSpacing: '15px' }"
          >
            技術選定ではもう迷わない
          </h1>
          <h3
            class="subheading"
            :style="{ letterSpacing: '5px' }"
          >
            開発で使うツールのレビュー/勉強会
          </h3>
        </v-col>
      </v-row>
    </v-img>
    <div>
      <v-container>
        <v-row>
          <v-col cols="12">
            <v-card-text class="text-h5">注目記事</v-card-text>
          </v-col>
        </v-row>
      </v-container>
    </div>
    <div>
      <v-container>
        <v-card-text class="text-h5 border-bottom">開催間近イベント</v-card-text>
      </v-container>
    </div>
  </div>
</template>

<script>
export default {
  data () {
    return {
      model: [],
      imgHeight: 250
    }
  },
  created () {}
}
</script>
