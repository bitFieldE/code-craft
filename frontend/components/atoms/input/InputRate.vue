<template>
  <v-card-text>
    <ValidationProvider
      :name="$attrs.label"
      :rules="rules"
      :vid="$attrs.vid"
    >
      <v-container>
        <v-row justify="center" align="center">
          <v-col cols="8">
            <v-card-subtitle>ツールレビュー（必須）</v-card-subtitle>
            <v-card-actions>
              <v-rating
                v-model="inputValue"
                class="d-none d-sm-inline"
                v-bind="$attrs"
                color="yellow darken-3"
                dense
                v-on="$listeners"
              />
              <v-rating
                v-model="inputValue"
                v-bind="$attrs"
                class="d-inline d-sm-none"
                color="yellow darken-3"
                dense
                small
                v-on="$listeners"
              />
              <span class="font-weight-bold">
                ( {{ inputValue }} )
              </span>
            </v-card-actions>
          </v-col>
        </v-row>
      </v-container>
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
