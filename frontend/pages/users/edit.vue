<template>
  <v-container class="col-xs-12 col-sm-8 col-md-6">
    <v-card>
      <v-tabs
        v-model="tab"
        fixed-tabs
        centered
        color="info"
        background-color="greyLight4"
      >
        <v-tab>
          <v-icon>mdi-account-edit</v-icon>
          プロフィール
        </v-tab>
        <v-tab>
          <v-icon>mdi-account-lock</v-icon>
          パスワード
        </v-tab>
      </v-tabs>
      <v-tabs-items v-model="tab" touchless>
        <v-tab-item>
          <editUser />
        </v-tab-item>
        <v-tab-item>
          <v-container>
            <editPassword />
          </v-container>
        </v-tab-item>
      </v-tabs-items>
    </v-card>
  </v-container>
</template>

<script>
import editUser from '~/components/template/users/editUser'
import editPassword from '~/components/template/users/editPassword'

export default {
  middleware: 'authenticated',
  components: {
    editUser,
    editPassword
  },
  data () {
    return {
      tab: null
    }
  }
}
</script>
