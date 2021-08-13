import colors from 'vuetify/es5/util/colors'

export default {
  // Disable server-side rendering: https://go.nuxtjs.dev/ssr-mode
  ssr: false,

  // Global page headers: https://go.nuxtjs.dev/config-head
  head: {
    titleTemplate: '%s - app',
    title: 'app',
    htmlAttrs: {
      lang: 'en'
    },
    meta: [
      { charset: 'utf-8' },
      { name: 'viewport', content: 'width=device-width, initial-scale=1' },
      { hid: 'description', name: 'description', content: '' }
    ],
    link: [
      { rel: 'icon', type: 'image/x-icon', href: '/favicon.ico' }
    ]
  },

  // Global CSS: https://go.nuxtjs.dev/config-css
  css: [
    { src: '~/node_modules/highlight.js/styles/hopscotch.css', lang: 'css' },
    '~/assets/sass/main.scss'
  ],

  // Plugins to run before rendering page: https://go.nuxtjs.dev/config-plugins
  plugins: [
    'plugins/auth',
    'plugins/axios',
    'plugins/vee-validate',
    'plugins/nuxtClientInit',
    'plugins/vue-mavon-editor'
  ],

  // Auto import components: https://go.nuxtjs.dev/config-components
  components: true,

  // Modules for dev and build (recommended): https://go.nuxtjs.dev/config-modules
  buildModules: [
    // https://go.nuxtjs.dev/eslint
    '@nuxtjs/eslint-module',
    // https://go.nuxtjs.dev/vuetify
    '@nuxtjs/vuetify',
    '@nuxtjs/moment'
  ],

  moment: {
    locales: ['ja']
  },

  // Modules: https://go.nuxtjs.dev/config-modules
  modules: [
    // https://go.nuxtjs.dev/axios
    '@nuxtjs/axios',
    '@nuxtjs/markdownit',
    'nuxt-i18n'
  ],

  markdownit: {
    injected: true,
    breaks: true,
    html: true,
    linkify: true,
    typography: true,
    langPrefix: '',
    use: [
      'markdown-it-mark',
      'markdown-it-ins',
      'markdown-it-emoji'
    ],
    highlight: (str, lang) => {
      const hljs = require('highlight.js');
      if (lang && hljs.getLanguage(lang)) {
        try {
          return '<pre class="hljs"><code>' +
                  hljs.highlight(str, { language: lang, ignoreIllegals: true }).value +
                  '</code></pre>';
        } catch (__) {}
      }
      // 言語設定がない場合、プレーンテキストとして表示する
      return '<pre class="hljs"><code>' +  hljs.highlight('plaintext', str, true).value + '</code></pre>';
    }
  },

  // Axios module configuration: https://go.nuxtjs.dev/config-axios
  axios: {
    baseURL: process.env.NODE_ENV === 'production' ? 'https://codecraftapp.net' : process.env.BACKEND_URL,
    credentials: true
  },

  router: {},

  // Vuetify module configuration: https://go.nuxtjs.dev/config-vuetify
  vuetify: {
    customVariables: ['~/assets/sass/variables.scss'],
    treeShake: true,
    theme: {
      themes: {
        light: {
          primary: colors.blue.darken2,
          accent: colors.grey.darken3,
          secondary: colors.amber.darken3,
          info: colors.teal.lighten1,
          warning: colors.amber.base,
          error: colors.deepOrange.accent4,
          success: colors.green.accent3,
          limeColor: colors.lime.accent2,
          cyanLight5: colors.cyan.lighten5,
          greyLight4: colors.grey.lighten4
        }
      }
    }
  },

   // Doc: https://nuxt-community.github.io/nuxt-i18n/basic-usage.html#nuxt-link
   i18n: {
    strategy: 'no_prefix',
    locales: ['ja', 'en'],
    defaultLocale: 'ja',
    // Doc: https://kazupon.github.io/vue-i18n/api/#properties
    vueI18n: {
      fallbackLocale: 'ja',
      // silentTranslationWarn: true,
      silentFallbackWarn: true,
      messages: {
        ja: require('./locales/ja.json'),
        en: require('./locales/en.json')
      }
    }
  },

  // Doc: https://nuxtjs.org/guide/runtime-config/
  publicRuntimeConfig: {
    appName: process.env.APP_NAME,
    cryptoKey: process.env.CRYPTO_KEY
  },

  // Build Configuration: https://go.nuxtjs.dev/config-build
  build: {
    transpile: [
      'vee-validate/dist/rules'
    ]
  }
}
