<template>
  <v-container>
    <v-row
      v-if="loading"
      class="mb-3"
    >
      <v-col
        v-for="n in 6"
        :key="n"
        xs="12"
        sm="6"
        md="6"
        cols="12"
      >
        <v-skeleton-loader
          type="card"
        />
      </v-col>
    </v-row>
    <v-row
      v-else
      class="mb-3"
    >
      <v-col
        v-for="event in displayEvents"
        :key="event.id"
        xs="12"
        sm="6"
        md="6"
        cols="12"
      >
        <v-card>
          <v-img
            :src="event.image_url ? event.image_url : '/images/no_img.png'"
            min-height="170"
            max-height="170"
          >
            <v-card-text>
              <div class="float-right">
                <EventModal
                  :event="event"
                  :post="event.post"
                />
              </div>
            </v-card-text>
          </v-img>
          <v-card-title>
            {{ event.title }}
          </v-card-title>
          <v-card-subtitle class="pt-2">
            <v-icon>
              mdi-calendar
            </v-icon>
            <span>開催日: </span>
            {{ $moment(event.scheduled_date).format('YYYY/MM/DD') }}
          </v-card-subtitle>
          <v-card-subtitle class="pt-0">
            <v-icon>
              mdi-alarm-check
            </v-icon>
            <span>開始時刻: </span>
            {{ $moment(event.start_time).format('HH : mm') }}
          </v-card-subtitle>
          <v-card-text
            v-if="event.tags.length > 0"
            class="py-0"
          >
            <v-chip-group
              class="w-100"
              active-class="primary--text"
              column
            >
              <v-chip
                v-for="tag in event.tags"
                :key="tag.id"
                color="info"
                outlined
                small
              >
                <nuxt-link
                  :to="{ path: `/tags/${tag.id}` }"
                  style="color: inherit; text-decoration: none;"
                >
                  {{ tag.name }}
                </nuxt-link>
              </v-chip>
            </v-chip-group>
          </v-card-text>
          <nuxt-link
            :to="{ path: `/users/${event.user.id}` }"
            style="color: inherit; text-decoration: none;"
          >
            <v-card-text>
              <v-avatar
                v-if="event.user.image_url"
                size="25"
              >
                <v-img
                  :src="event.user.image_url"
                />
              </v-avatar>
              <v-icon
                v-else
              >
                mdi-account-circle
              </v-icon>
              {{ event.user.name }}
            </v-card-text>
          </nuxt-link>
        </v-card>
      </v-col>
    </v-row>
    <v-pagination
      v-model="page"
      color="info"
      :length="EventsLength"
      @input="pageChange"
    />
  </v-container>
</template>

<script>
import EventModal from '~/components/molecles/events/EventModal'

export default {
  components: {
    EventModal
  },
  props: {
    events: {
      type: Array,
      default: () => []
    },
    loading: {
      type: Boolean,
      default: null
    }
  },
  data () {
    return {
      page: 1,
      length: 0,
      pageSize: 10
    }
  },
  computed: {
    displayEvents () {
      if (this.events.length > 10) {
        return this.events.slice(this.pageSize * (this.page - 1), this.pageSize * (this.page))
      } else {
        return this.events
      }
    },
    EventsLength () {
      return Math.ceil(this.events.length / this.pageSize)
    }
  },
  methods: {
    pageChange (pageNumber) {
      this.displayEvents.slice(this.pageSize * (pageNumber - 1), this.pageSize * (pageNumber))
    }
  }
}
</script>
