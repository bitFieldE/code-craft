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
        :nudge-right="40"
        transition="scale-transition"
        offset-y
        min-width="auto"
      >
        <template #activator="{ on, attrs }">
          <v-text-field
            v-model="date"
            label="開催日"
            prepend-icon="mdi-calendar"
            readonly
            v-bind="attrs"
            v-on="on"
          />
        </template>
        <v-date-picker
          v-model="date"
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
  data () {
    return {
      date: new Date().toLocaleDateString().replace(/\//g, '-'),
      menu: false
    }
  },
  computed: {
    getEndDate () {
      const endDay = new Date()
      endDay.setFullYear(new Date().getFullYear() + 1)
      return endDay.toISOString().substr(0, 10)
    }
  }
}
</script>
