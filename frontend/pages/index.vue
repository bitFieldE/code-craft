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
            開発で使うツールのレビュー
          </h3>
        </v-col>
      </v-row>
    </v-img>
    <div>
      <pre class="prettyprint linenums">
        mounted () {
          // https://github.com/google/code-prettify/issues/578
          const prettyPrint = require('code-prettify')
          this.$nextTick(function () {
            prettyPrint.prettyPrint()
          })
        }
        mounted () {
          // https://github.com/google/code-prettify/issues/578
          const prettyPrint = require('code-prettify')
          this.$nextTick(function () {
            prettyPrint.prettyPrint()
          })
        }
      </pre>
    </div>
    <div>
      {{ $auth.user }}
      <pre class="prettyprint linenums" />
    </div>
    <div>
      <pre class="prettyprint linenums">
        mounted () {
          // https://github.com/google/code-prettify/issues/578
          const prettyPrint = require('code-prettify')
          this.$nextTick(function () {
            prettyPrint.prettyPrint()
          })
        }
        mounted () {
          // https://github.com/google/code-prettify/issues/578
          const prettyPrint = require('code-prettify')
          this.$nextTick(function () {
            prettyPrint.prettyPrint()
          })
        }
      </pre>
    </div>
  </div>
</template>

<script>
export default {
  data () {
    return {
      imgHeight: 300
    }
  },
  head () {
    return {
      script: [
        { src: 'https://cdn.jsdelivr.net/gh/google/code-prettify@master/loader/run_prettify.js?skin=doxy' }
      ]
    }
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
