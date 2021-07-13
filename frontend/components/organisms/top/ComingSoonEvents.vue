<template>
  <v-container>
    <v-row v-if="loading">
      <v-col
        v-for="n in 6"
        :key="n"
        xs="12"
        sm="6"
        md="4"
        cols="12"
      >
        <v-skeleton-loader
          type="card"
        />
      </v-col>
    </v-row>
    <v-row v-else>
      <v-col
        v-for="event in events"
        :key="event.id"
        xs="12"
        sm="6"
        md="4"
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
          <v-card-subtitle class="pb-0">
            {{ $moment(event.scheduled_date).format('YYYY/MM/DD') }}
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
  }
}
</script>
