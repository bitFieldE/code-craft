<template>
  <ValidationProvider
    v-slot="ProviderProps"
    :name="$attrs.label"
    :rules="rules"
    :vid="$attrs.vid"
  >
    <v-row justify="center" class="py-7">
      <v-badge
        bordered
        color="black"
        icon="mdi-plus"
        overlap
        bottom
        offset-x="15"
        offset-y="17"
      >
        <v-avatar
          size="80"
          @click="changeAvator"
        >
          <v-img v-if="userImageURL" :src="userImageURL" />
          <v-img v-else-if="$auth.user.image_url" :src="$auth.user.image_url" />
          <v-icon v-else size="95">
            mdi-account-circle
          </v-icon>
        </v-avatar>
      </v-badge>
    </v-row>
    <v-file-input
      id="fileInput"
      v-model="inputValue"
      style="display:none"
      v-bind="$attrs"
      accept="image/*"
      v-on="$listeners"
      @change="convertImage"
    />
    <span class="error-msg">{{ ProviderProps.errors[0] }}</span>
  </ValidationProvider>
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
    userImage: {
      type: null,
      default: ''
    }
  },
  data () {
    return {
      userImageURL: ''
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
    changeAvator () {
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
          this.userImageURL = fr.result
        })
      } else {
        this.userImageURL = ''
      }
    }
  }
}
</script>

<style>
  .error-msg {
    color: #dd2c00;
    font-size: 12px;
  }
</style>
