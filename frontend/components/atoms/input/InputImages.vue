<template>
  <v-container>
    <v-row>
      <v-col v-for="(showImage, index) in showImages" :key="index" xs="2" sm="2" cols="2">
        <v-card>
          <v-img
            :src="showImage"
            :height="100"
            cols="12"
          />
          <v-divider />
          <v-card-text>
            <a @click="deleteFile(index)">削除</a>
          </v-card-text>
        </v-card>
      </v-col>
      <v-col
        v-if="showImages.length < 5"
        class="drop_area"
        outlined
        :class="{enter: isEnter}"
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
        画像アップロード(5枚まで)
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
      showImages: []
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
    font-weight: bold;
    font-size: 1.2em;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 200px;
    border: 5px solid gray;
  }
  .enter {
    border: 5px dotted powderblue;
  }
</style>
