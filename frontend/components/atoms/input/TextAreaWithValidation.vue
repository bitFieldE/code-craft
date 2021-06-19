<template>
  <ValidationProvider
    v-slot="{ errors }"
    :name="$attrs.label"
    :rules="rules"
    :vid="$attrs.vid"
  >
    <v-textarea
      v-model="inputValue"
      :error-messages="errors"
      outlined
      v-bind="$attrs"
      v-on="$listeners"
    />
  </ValidationProvider>
</template>
<script>
export default {
  props: {
    rules: {
      type: [Object, String],
      default: ''
    },
    value: {
      type: null,
      default: ''
    }
  },
  computed: {
    inputValue: {
      get () {
        return this.value
      },
      set (value) {
        this.$emit('input', value)
      }
    }
  }
}
</script>
