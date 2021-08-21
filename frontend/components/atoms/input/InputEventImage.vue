<template>
  <div>
    <v-img
      :src="eventImageURL ? eventImageURL : '/images/no_img.png'"
      max-height="200"
      max-width="300"
      @click="changeImage"
    >
      <div class="p-2 float-right">
        <v-file-input
          id="fileInput"
          v-model="inputValue"
          accept="image/*"
          prepend-icon="mdi-plus"
          hide-input
          @change="convertImage"
        />
      </div>
    </v-img>
  </div>
</template>

<script>
export default {
  props: {
    rules: {
      type: [Object, String],
      default: ''
    },
    value: {
      type: null,
      default: ''
    },
    image: {
      type: null,
      default: ''
    }
  },
  data () {
    return {
      eventImageURL: ''
    }
  },
  computed: {
    inputValue: {
      get () {
        return this.value
      },
      set (value) {
        this.$emit('input', value)
      }
    }
  },
  mounted () {
    if (this.image) {
      this.eventImageURL = this.image
    }
  },
  methods: {
    changeImage () {
      document.getElementById('fileInput').click()
    },
    convertImage (file) {
      if (file !== undefined && file !== null) {
        if (file.name.lastIndexOf('.') <= 0) {
          return
        }
        const fr = new FileReader()
        fr.readAsDataURL(file)
        fr.addEventListener('load', () => {
          this.eventImageURL = fr.result
        })
      } else {
        this.eventImageURL = ''
      }
    }
  }
}
</script>
