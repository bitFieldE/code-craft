<template>
  <v-row>
    <v-col
      cols="12"
      sm="6"
      md="4"
    >
      <v-menu
        v-model="menu"
        :close-on-content-click="false"
        transition="scale-transition"
        offset-y
        min-width="auto"
      >
        <template #activator="{ on, attrs }">
          <v-text-field
            v-model="inputValue"
            label="開催日"
            prepend-icon="mdi-calendar"
            readonly
            v-bind="attrs"
            v-on="on"
          />
        </template>
        <v-date-picker
          v-model="inputValue"
          locale="ja"
          color="info"
          :min="new Date().toISOString().substr(0, 10)"
          :max="getEndDate"
          :day-format="date => new Date(date).getDate()"
          @input="menu= false"
        />
      </v-menu>
    </v-col>
  </v-row>
</template>

<script>
export default {
  props: {
    value: {
      type: String,
      default: ''
    }
  },
  data () {
    return {
      menu: false
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
    getEndDate () {
      const endDay = new Date()
      endDay.setFullYear(new Date().getFullYear() + 1)
      return endDay.toISOString().substr(0, 10)
    }
  }
}
</script>
