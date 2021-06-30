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
      <v-sheet
        class="mx-auto"
      >
        <v-slide-group
          v-model="model"
          class="pa-4"
          multiple
          show-arrows
        >
          <v-slide-item
            v-for="n in 15"
            :key="n"
            v-slot="{ active, toggle }"
          >
            <v-card
              :color="active ? 'primary' : 'grey lighten-1'"
              class="ma-4"
              height="200"
              width="150"
              @click="toggle"
            >
              <v-row
                class="fill-height"
                align="center"
                justify="center"
              >
                <v-scale-transition>
                  <v-icon
                    v-if="active"
                    color="white"
                    size="48"
                    v-text="'mdi-close-circle-outline'"
                  ></v-icon>
                </v-scale-transition>
              </v-row>
            </v-card>
          </v-slide-item>
        </v-slide-group>
      </v-sheet>
    </div>
    <div>
      {{ $auth.user }}
    </div>
  </div>
</template>

<script>
export default {
  data () {
    return {
      model: [],
      imgHeight: 300
    }
  },
  created () {
    
  }
}
</script>

<style>
  .prettyprint ol.linenums > li {
    list-style-type: decimal;
    /* または */
    list-style-type: decimal-leading-zero;
  }
</style>
