export const state = () => ({
  event: {},
  events: [],
  participants: []
})

export const getters = {
  event: state => state.event,
  events: state => state.events,
  participants: state => state.participants
}

export const mutations = {
  setEvent (state, event) {
    state.event = event
  },
  setEvents (state, events) {
    state.events = events
  },
  setParticipants (state, participants) {
    state.participants = participants
  },
  addEvent (state, event) {
    state.events.push(event)
  },
  updateEvent (state, eventData) {
    state.events = state.events.map((event) => {
      if (event.id === eventData.id) {
        event = eventData
      }
      return event
    })
  },
  deleteEvent (state, eventId) {
    state.events = state.events.filter(event => event.id !== eventId)
  },
  deleteEvents (state, postId) {
    state.events = state.events.filter(event => event.post_id !== postId)
  },
  addParticipant (state, participant) {
    state.participants.push(participant)
  },
  deleteParticipants (state, userId) {
    state.participants = state.participants.filter(participant => participant.id !== userId)
  }
}
