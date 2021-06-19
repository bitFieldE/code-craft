import Vue from 'vue'
import { ValidationProvider, ValidationObserver, extend, localize } from 'vee-validate'
import * as rules from 'vee-validate/dist/rules'
import ja from 'vee-validate/dist/locale/ja.json'

// 全てのバリデーションルールを登録する
Object.keys(rules).forEach((rule) => {
  extend(rule, rules[rule]) // eslint-disable-line
})

extend('email', (value) => {
  return /.+@.+\..+/.test(value) || '有効なメールアドレスではありません'
})

extend('password', (value) => {
  return /^[\w-]{8,72}$/.test(value) || '8文字以上。半角英数字/ﾊｲﾌﾝ/ｱﾝﾀﾞｰﾊﾞｰが使えます'
})

localize('ja', ja)

Vue.component('ValidationProvider', ValidationProvider)
Vue.component('ValidationObserver', ValidationObserver)
