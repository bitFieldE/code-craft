<template>
  <v-combobox
    v-model.trim="inputValue"
    multiple
    label="言語/技術を入力"
    append-icon
    small-chips
    deletable-chips
    outlined
    no-data-text
    :error-messages="errormessage"
    class="tag-input"
    :search-input.sync="search"
    @keyup.tab="updateTags"
    @paste="updateTags"
  />
</template>

<script>
export default {
  props: {
    value: {
      type: Array,
      default: () => []
    }
  },
  data () {
    return {
      errormessage: ''
    }
  },
  computed: {
    inputValue: {
      get () {
        // タグの空文字入力を無効化させる
        return this.value.filter(v => v.match(/\S/g))
      },
      set (value) {
        this.$emit('input', value)
      }
    }
  },
  watch: {
    inputValue (value) {
      if (value.length > 5) {
        this.$nextTick(() => this.inputValue.pop())
        this.errormessage = 'タグは5個まで登録できます'
      }
    }
  },
  methods: {
    updateTags () {
      this.$nextTick(() => {
        this.inputValue.push(...this.search.split(','))
        this.$nextTick(() => {
          this.search = ''
        })
      })
    }
  }
}
</script>
