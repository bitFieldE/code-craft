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
      <v-card-title>
        {{ event.title }}
      </v-card-title>
      <v-img
        :src="event.image.url ? event.image.url : '/images/no_img.png'"
        max-height="300"
      />
      <v-card-text>
        <v-timeline
          align-top
          dense
        >
          <v-timeline-item
            color="light-green lighten-4"
            icon="mdi-card-text-outline"
            fill-dot
          >
            <span>関連記事</span>
            <v-card-text class="shadow px-0">
              <nuxt-link
                :to="{ path: `/posts/${event.post.id}` }"
                style="color: inherit; text-decoration: none;"
              >
                <v-card>
                  <v-card-text class="pb-0">
                    {{ $moment(event.post.created_at).format('YYYY/MM/DD HH:MM') }}
                  </v-card-text>
                  <v-card-title class="pb-0" style="font-size: 15px;">
                    {{ event.post.title }}
                  </v-card-title>
                  <v-card-actions class="ml-2">
                    <v-rating
                      :value="event.post.rate"
                      color="yellow darken-3"
                      background-color="grey darken-1"
                      readonly
                      half-increments
                      dense
                      small
                    />
                    <span class="rate pl-1">
                      ( {{ event.post.rate }} )
                    </span>
                  </v-card-actions>
                </v-card>
              </nuxt-link>
            </v-card-text>
          </v-timeline-item>
          <v-timeline-item
            color="lime accent-4"
            icon="mdi-pin"
            fill-dot
          >
            <div>
              <v-icon>
                mdi-map-marker-outline
              </v-icon>
              <span>場所</span>
              <div class="text-h6">
                {{ event.place }}
              </div>
            </div>
          </v-timeline-item>
          <v-timeline-item
            color="green accent-1"
            icon="mdi-calendar-month-outline"
            fill-dot
          >
            <div>
              <v-icon>
                mdi-calendar
              </v-icon>
              <span>開催日</span>
              <div class="text-h6">
                {{ $moment(event.scheduled_date).format('YYYY/MM/DD') }}
              </div>
            </div>
          </v-timeline-item>
          <v-timeline-item color="purple lighten-4" small>
            <div>
              <v-icon>
                mdi-clock-time-three-outline
              </v-icon>
              <span>開催時間</span>
              <div class="text-h6">
                {{ $moment(event.start_time).format('HH : mm') }}
              </div>
            </div>
          </v-timeline-item>

          <v-timeline-item color="purple lighten-4" small>
            <div>
              <v-icon>
                mdi-clock-time-three
              </v-icon>
              <span>終了時間</span>
              <div class="text-h6">
                {{ $moment(event.end_time).format('HH : mm') }}
              </div>
            </div>
          </v-timeline-item>

          <v-timeline-item color="white">
            <template #icon>
              <v-avatar size="40">
                <v-img
                  v-if="event.user.image.url"
                  :src="event.user.image.url"
                />
                <v-icon
                  v-else
                  size="40"
                >
                  mdi-account-circle
                </v-icon>
              </v-avatar>
            </template>
            <v-card>
              <v-card-subtitle class="pb-0">
                <span class="font-weight-bold">
                  {{ event.user.name }}
                </span>
                さんより
              </v-card-subtitle>
              <v-card-text>
                {{ event.content }}
              </v-card-text>
            </v-card>
          </v-timeline-item>
        </v-timeline>
      </v-card-text>
      <v-card-text v-if="$auth.loggedIn">
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
