<template>
  <v-container>
    <v-row
      class="drop_area"
      outlined
      :class="{enter: isEnter}"
    >
      <v-col cols="12" class="text-center">
        画像アップロード(5枚まで)
      </v-col>
      <template v-if="showImages.length > 0">
        <v-col
          v-for="(showImage, index) in showImages"
          :key="index"
          class="text-center"
          style="min-width:100px;"
          cols="2"
        >
          <v-sheet>
            <v-img
              :src="showImage"
              :height="100"
              cols="12"
            />
          </v-sheet>
          <v-card-text>
            <v-btn
              color="error"
              @click="deleteFile(index)"
              x-small
            >
              削除
            </v-btn>
          </v-card-text>
        </v-col>
      </template>
      <v-col
        style="min-height: 180px;"
        @click="clickDropArea"
        @dragenter="dragEnter"
        @dragleave="dragLeave"
        @dragover.prevent
        @drop.prevent="uploadFile($event)"
      >
        <input
          id="fileInput"
          type="file"
          accept="image/*"
          multiple="multiple"
          style="display:none"
          @change="uploadFile($event)"
        >
      </v-col>
    </v-row>
  </v-container>
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
      isEnter: false,
      showImages: [],
      image
    }
  },
  mounted () {
    if (this.value.length > 0) {
      this.value.forEach((image) => {
        this.showImages.push(image.url)
      })
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
  methods: {
    dragEnter () {
      this.isEnter = true
    },
    dragLeave () {
      this.isEnter = false
    },
    uploadFile (e) {
      // ドラッグアンドドロップ処理とクリック処理
      const fileImages = e.target.files || e.dataTransfer.files
      const totalImages = this.showImages.length + fileImages.length

      if (totalImages <= 5) {
        fileImages.forEach((fileImage) => {
          const reader = new FileReader()
          // readAdDataURLが完了したあと実行される処理
          reader.onload = (e) => {
            this.showImages.push(e.target.result)
          }
          this.inputValue.push(fileImage)
          reader.readAsDataURL(fileImage)
        })
      } else {
        this.$store.dispatch(
          'flash/showMessage',
          {
            message: '容量オーバー',
            type: 'warning',
            status: true
          },
          { root: true }
        )
      }
      this.isEnter = false
    },
    clickDropArea () {
      document.getElementById('fileInput').click()
    },
    deleteFile (index) {
      this.showImages.splice(index, 1)
      this.inputValue.splice(index, 1)
    }
  }
}
</script>

<style>
  .drop_area {
    color: gray;
    min-height: 240.3px;
    font-weight: bold;
    font-size: 1.2em;
    border: 3px solid;
  }
  .enter {
    border: 5px dotted powderblue;
  }
</style>
