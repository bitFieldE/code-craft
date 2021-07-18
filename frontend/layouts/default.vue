<template>
  <v-app>
    <Header />
    <v-main class="grey lighten-5">
      <nuxt />
    </v-main>
    <Flash />
    <Footer />
  </v-app>
</template>

<script>
import Header from '~/components/organisms/top/Header'
import Footer from '~/components/organisms/top/Footer'
import Flash from '~/components/atoms/top/Flash'

export default {
  components: {
    Header,
    Flash,
    Footer
  }
}
</script>
