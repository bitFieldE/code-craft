/* eslint-disable */

const Vuex = require('vuex')
const events = require('../store/events')
const { createLocalVue } = require('@vue/test-utils')
const cloneDeep = require('lodash.clonedeep')

const localVue = createLocalVue()
localVue.use(Vuex)

describe('イベントの表示', () => {
  let store

  beforeEach(() => {
    store = new Vuex.Store(cloneDeep(events))
  })

  describe('actions', () => {
    test('イベントの内容が表示されること', async () => {
      const payload = [
        { 
          title: 'test-title',
          place: 'test-place',
          scheduled_date: '2021/08/01',
          start_time: '15:00',
          end_time: '18:00',
          participant_number: 10,
          content: 'test-content',
          tags: ['test1', 'test2']
        },
        { 
          title: 'test-title2',
          place: 'test-place2',
          scheduled_date: '2021/08/07',
          start_time: '17:00',
          end_time: '19:00',
          participant_number: 12,
          content: 'test-content2',
          tags: ['test3', 'test4']
        }
      ]
      await store.commit('setEvents', payload)
      expect(store.getters['events']).toEqual(payload)
    })
  })
})

/* eslint-enable */