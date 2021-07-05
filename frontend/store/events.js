export const state = () => ({
  event: {},
  events: [],
  joinedEvents: [],
  participants: []
})

export const getters = {
  event: state => state.event,
  events: state => state.events,
  joinedEvents: state => state.joinedEvents,
  participants: state => state.participants
}

export const mutations = {
  setEvent (state, event) {
    state.event = event
  },
  setEvents (state, events) {
    state.events = events
  },
  setJoinedEvents (state, joinedEvents) {
    state.joinedEvents = joinedEvents
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
  addJoinedEvent (state, event) {
    state.joinedEvents.push(event)
  },
  deleteJoinedEvent (state, eventId) {
    state.joinedEvents = state.joinedEvents.filter(event => event.id !== eventId)
  },
  deleteJoinedEvents (state, event) {
    state.joinedEvents.push(event)
  },
  addParticipant (state, participant) {
    state.participants.push(participant)
  },
  deleteParticipants (state, userId) {
    state.participants = state.participants.filter(participant => participant.id !== userId)
  }
}
