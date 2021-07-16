<template>
  <v-container>
    <TextFieldWithValidation
      v-model="keyword"
      prepend-icon="mdi-magnify"
      @keyup="searchEvents"
    />
    <v-row v-if="loading">
      <v-col
        v-for="n in 6"
        :key="n"
        cols="12"
        xs="12"
        sm="6"
        md="6"
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
        cols="12"
        xs="12"
        sm="6"
        md="6"
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
              <v-col
                v-if="event.user.id==$auth.user.id"
                cols="12"
              >
                <div class="float-right mt-2 mr-2">
                  <EditStudyEvent
                    :post="event.post"
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
          <v-card-text
            class="pt-0"
          >
            <v-btn
              class="pt-0"
              icon
              @click="deleteEvent(event.id)"
            >
              <v-icon>
                mdi-trash-can-outline
              </v-icon>
            </v-btn>
          </v-card-text>
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
import TextFieldWithValidation from '~/components/atoms/input/TextFieldWithValidation'
import EventModal from '~/components/molecles/events/EventModal'
import EditStudyEvent from '~/components/molecles/users/EditStudyEvent'

export default {
  components: {
    TextFieldWithValidation,
    EventModal,
    EditStudyEvent
  },
  data () {
    return {
      page: 1,
      length: 0,
      pageSize: 6,
      loading: false,
      events: [],
      keyword: ''
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
  async mounted () {
    this.loading = true
    await this.$axios.get('api/v1/admin/events')
      .then((response) => {
        this.events = response.data
      })
      .catch((error) => {
        return error
      })
    this.loading = false
  },
  methods: {
    async searchEvents () {
      this.loading = true
      await this.$axios.get('api/v1/admin/events', {
        params: {
          keyword: this.keyword
        }
      }).then((response) => {
        this.events = response.data
      })
        .catch((error) => {
          return error
        })
      this.loading = false
    },
    async deleteEvent (eventId) {
      if (window.confirm('削除してもよろしいですか？')) {
        await this.$axios.$delete(`/api/v1/events/${eventId}`)
          .then(
            (response) => {
              this.events = this.events.filter(event => event.id !== eventId)
              this.$store.dispatch(
                'flash/showMessage',
                {
                  message: response.message,
                  color: 'primary',
                  status: true
                },
                { root: true }
              )
            },
            (error) => {
              this.$store.dispatch(
                'flash/showMessage',
                {
                  message: error,
                  color: 'error',
                  status: true
                },
                { root: true }
              )
              return error
            }
          )
      }
    },
    pageChange (pageNumber) {
      this.displayEvents.slice(this.pageSize * (pageNumber - 1), this.pageSize * (pageNumber))
    }
  }
}
</script>
