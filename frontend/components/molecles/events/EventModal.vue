<template>
  <v-dialog
    v-model="dialog"
    persistent
    max-width="600"
  >
    <template #activator="{ on, attrs }">
      <v-btn
        v-bind="attrs"
        class="m-4 float-right"
        color="warning"
        small
        fab
        v-on="on"
      >
        <v-icon>
          mdi-text-box-outline
        </v-icon>
      </v-btn>
    </template>
    <v-card>
      <v-img
        src="/images/no_img.png"
      >
        <v-card-cations>
          <v-btn
            class="float-right"
            icon
            @click="dialog=false"
          >
            <v-icon>
              mdi-close
            </v-icon>
          </v-btn>
        </v-card-cations>
      </v-img>
      <v-card-title>
        {{ event.title }}
      </v-card-title>
      <v-card-text>
        <v-timeline
          align-top
          dense
        >
          <v-timeline-item
            color="pink"
            small
          >
            <v-row class="pt-1">
              <v-col cols="3">
                <strong>5pm</strong>
              </v-col>
              <v-col>
                <strong>New Icon</strong>
                <div class="text-caption">
                  Mobile App
                </div>
              </v-col>
            </v-row>
          </v-timeline-item>

          <v-timeline-item
            color="pink"
            small
          >
            <v-card-text>
              {{ $moment(event.start_time).format('HH : mm') }}
            </v-card-text>
            <template #append>
              <v-btn
                class="mx-0"
                depressed
              >
                Post
              </v-btn>
            </template>
          </v-timeline-item>

          <v-timeline-item
            color="pink"
            small
          >
            <v-card-text>
              {{ $moment(event.end_time).format('HH : mm') }}
            </v-card-text>
          </v-timeline-item>

          <v-timeline-item
            color="teal lighten-3"
            large
          >
            <v-card>
              <v-card-text>
                {{ event.content }}
              </v-card-text>
            </v-card>
          </v-timeline-item>
        </v-timeline>
      </v-card-text>
    </v-card>
  </v-dialog>
</template>

<script>
export default {
  props: {
    event: {
      type: Object,
      default: () => {}
    }
  },
  data () {
    return {
      dialog: false
    }
  }
}
</script>
