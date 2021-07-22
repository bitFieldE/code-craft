/* eslint-disable */

const Vuex = require('vuex')
const messages = require('../store/flash')
const { createLocalVue } = require('@vue/test-utils')
const cloneDeep = require('lodash.clonedeep')

const localVue = createLocalVue()
localVue.use(Vuex)

describe('フラッシュメッセージの表示', () => {
  let store

  beforeEach(() => {
    store = new Vuex.Store(cloneDeep(messages))
  })

  describe('actions', () => {
    test('フラッシュメッセージが表示されるか', async () => {
      const payload = { message: "testmessage", color: "info", root: "true" }
      await store.dispatch('showMessage', payload)
      expect(store.getters['message']).toEqual(payload.message)
    })
  })
})

/* eslint-enable */