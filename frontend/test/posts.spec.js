/* eslint-disable */

const Vuex = require('vuex')
const posts = require('../store/posts')
const { createLocalVue } = require('@vue/test-utils')
const cloneDeep = require('lodash.clonedeep')

const localVue = createLocalVue()
localVue.use(Vuex)

describe('レビュー記事の表示', () => {
  let store

  beforeEach(() => {
    store = new Vuex.Store(cloneDeep(posts))
  })

  describe('actions', () => {
    const payload = [
      { 
        id: 1,
        title: 'test-title',
        rate: 4.5,
        content: 'test-content',
        tags: ['test1', 'test2']
      },
      { 
        id: 2,
        title: 'test-title2',
        rate: 4.0,
        content: 'test-content2',
        tags: ['test3', 'test4']
      },
      { 
        id: 3,
        title: 'test-title3',
        rate: 4.0,
        content: 'test-content3',
        tags: ['test5', 'test6']
      }
    ]
    it('投稿内容が表示されること', async () => {
      await store.commit('setPosts', payload)
      await store.commit('setLikedPosts', payload)
      await store.commit('setFamousPosts', payload)
      expect(store.getters['posts']).toEqual(payload)
      expect(store.getters['likedPosts']).toEqual(payload)
      expect(store.getters['famousPosts']).toEqual(payload)
    })
    it('お気に入りの記事を削除できること', async () => {
      const testResult = [
        { 
          id: 2,
          title: 'test-title2',
          rate: 4.0,
          content: 'test-content2',
          tags: ['test3', 'test4']
        },
        { 
          id: 3,
          title: 'test-title3',
          rate: 4.0,
          content: 'test-content3',
          tags: ['test5', 'test6']
        }
      ]
      await store.commit('setLikedPosts', payload)
      await store.commit('deleteLikedPost', payload.shift().id, { root: true })
      expect(store.getters['likedPosts']).toEqual(testResult)
    })
  })
})

/* eslint-enable */