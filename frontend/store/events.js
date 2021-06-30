export const state = () => ({
  event: {},
  events: []
})

export const getters = {
  event: state => state.event,
  events: state => state.events
}

export const mutations = {
  setEvent (state, event) {
    state.event = event
  },
  setEvents (state, events) {
    state.events = events
  },
  addEvent (state, event) {
    state.events.push(event)
  },
  deleteEvent (state, eventId) {
    state.events = state.events.filter(event => event.id !== eventId)
  }
}
