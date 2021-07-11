<template>
  <v-container>
    <TextFieldWithValidation
      v-model="word"
      prepend-icon="mdi-map-marker"
    />
  </v-container>
</template>

<script>
import TextFieldWithValidation from '~/components/atoms/input/TextFieldWithValidation'

export default {
  components: {
    TextFieldWithValidation
  },
  data () {
    return {
      word: ''
    }
  }
}
</script>
