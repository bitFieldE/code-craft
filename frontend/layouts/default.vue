<template>
  <v-app>
    <Header />
    <v-main style="background-color:#FAFAFA;">
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
