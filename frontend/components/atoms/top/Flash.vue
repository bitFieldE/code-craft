<template>
  <v-snackbar
    v-model="status"
    :color="color"
    transition="slide-x-reverse-transition"
    left
    bottom
    dense
    text
    outlined
  >
    {{ message }}
  </v-snackbar>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  computed: {
    ...mapGetters({
      message: 'flash/message',
      color: 'flash/color',
      status: 'flash/status'
    })
  }
}
</script>
