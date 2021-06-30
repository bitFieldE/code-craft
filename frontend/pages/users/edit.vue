<template>
  <v-container>
    <v-row  align="center" justify="center">
      <v-col cols="10" sm="12" xs="12" md="7" lg="6">
        <v-card>
          <v-tabs
            v-model="tab"
            fixed-tabs
            centered
            color="secondary"
            background-color="brown lighten-5"
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
          <v-divider />
          <DeleteUserBtn />
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import editUser from '~/components/template/users/editUser'
import editPassword from '~/components/template/users/editPassword'
import DeleteUserBtn from '~/components/atoms/DeleteUserBtn'

export default {
  components: {
    editUser,
    editPassword,
    DeleteUserBtn
  },
  middleware: 'loginAuth',
  data () {
    return {
      tab: null
    }
  }
}
</script>
