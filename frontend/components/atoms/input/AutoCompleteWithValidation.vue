<template>
  <ValidationProvider
    v-slot="{ errors }"
    :name="$attrs.label"
    :rules="rules"
    :vid="$attrs.vid"
  >
    <v-autocomplete
      v-model="inputValue"
      :items="participant"
      :error-messages="errors"
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
      type: Number,
      default: null
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
    },
    participant () {
      const participants = []
      for (let i = 1; i <= 50; i++) {
        participants.push(i)
      }
      return participants
    }
  }
}
</script>
