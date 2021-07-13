<template>
  <v-container>
    <v-row v-if="loading">
      <v-col
        v-for="n in 6"
        :key="n"
        md="4"
        sm="6"
        xs="12"
        cols="12"
      >
        <v-skeleton-loader
          type="card"
        />
      </v-col>
    </v-row>
    <v-row v-else>
      <v-col
        v-for="event in displayEvents"
        :key="event.id"
        md="4"
        sm="6"
        xs="12"
        cols="12"
      >
        <v-card class="mb-8">
          <v-img
            :src="event.image_url ? event.image_url : '/images/no_img.png'"
            min-height="150"
            max-height="150"
          >
            <v-row no-gutters>
              <v-col cols="12">
                <div class="float-right mt-2 mr-2">
                  <EventModal
                    :event="event"
                  />
                </div>
              </v-col>
            </v-row>
          </v-img>
          <v-card-title class="text-h5">
            {{ event.title }}
          </v-card-title>
          <v-card-subtitle>
            <span>開催日: </span>
            {{ $moment(event.scheduled_date).format('YYYY/MM/DD') }}
          </v-card-subtitle>
          <v-card-subtitle>
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
                class="white--text ml-0"
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
    <v-card-text>
      <v-pagination
        v-model="page"
        color="info"
        :length="EventsLength"
        @input="pageChange"
      />
    </v-card-text>
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
      pageSize: 6
    }
  },
  computed: {
    displayEvents () {
      return this.events.slice(this.pageSize * (this.page - 1), this.pageSize * (this.page))
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
