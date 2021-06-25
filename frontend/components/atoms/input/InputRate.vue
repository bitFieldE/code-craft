<template>
  <v-card-text class="text-center">
    <ValidationProvider
      :name="$attrs.label"
      :rules="rules"
      :vid="$attrs.vid"
    >
      <v-card-subtitle>ツールレビュー（必須）</v-card-subtitle>
      <v-card-actions>
        <v-rating
          v-model="inputValue"
          v-bind="$attrs"
          color="yellow darken-3"
          dense
          v-on="$listeners"
        />
        <span class="font-weight-bold">
          ( {{ inputValue }} )
        </span>
      </v-card-actions>
    </ValidationProvider>
  </v-card-text>
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
      default: 0
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
