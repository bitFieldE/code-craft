<template>
  <v-dialog
    v-model="dialog"
    persistent
    max-width="600"
  >
    <template #activator="{ on, attrs }">
      <v-btn
        v-bind="attrs"
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
      <v-banner class="grey lighten-5" sticky outlined>
        <v-btn
          icon
          @click="dialog=false"
        >
          <v-icon>
            mdi-close
          </v-icon>
        </v-btn>
      </v-banner>
      <v-img
        src="/images/no_img.png"
      />
      <v-card-subtitle class="text-h4 text-center">
        {{ event.title }}
      </v-card-subtitle>
      <v-card-text>
        <v-timeline
          align-top
          dense
        >
          <v-timeline-item
            color="lime accent-4"
            icon="mdi-pin"
            fill-dot
            large
          >
            <div>
              <span>場所</span>
              <div class="text-h5">
                {{ event.place }}
              </div>
            </div>
          </v-timeline-item>
          <v-timeline-item
            color="green accent-1"
            icon="mdi-calendar-month-outline"
            fill-dot
            large
          >
            <div>
              <span>開催日</span>
              <div class="text-h5">
                {{ $moment(event.scheduled_date).format('YYYY/MM/DD') }}
              </div>
            </div>
          </v-timeline-item>
          <v-timeline-item color="amber darken-2">
            <div>
              <span>開始時間</span>
              <div class="text-h6">
                {{ $moment(event.start_time).format('HH : mm') }}
              </div>
            </div>
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
            color="amber darken-2"
          >
            <div>
              <span>終了時刻</span>
              <div class="text-h6">
                {{ $moment(event.end_time).format('HH : mm') }}
              </div>
            </div>
          </v-timeline-item>

          <v-timeline-item
            color="white"
            large
          >
            <template #icon>
              <v-avatar>
                <v-img
                  v-if="event.user.image_url"
                  :src="event.user.image_url"
                />
                <v-icon
                  v-else
                  size="54"
                >
                  mdi-account-circle
                </v-icon>
              </v-avatar>
            </template>
            <v-card>
              <v-card-text>
                {{ event.content }}
              </v-card-text>
            </v-card>
          </v-timeline-item>
        </v-timeline>
      </v-card-text>
      <v-card-text>
        <JoinBtnGroup
          :event="event"
        />
      </v-card-text>
    </v-card>
  </v-dialog>
</template>

<script>
import JoinBtnGroup from '~/components/molecles/events/JoinBtnGroup'

export default {
  components: {
    JoinBtnGroup
  },
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
