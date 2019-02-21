<template>
  <v-layout>
    <v-toolbar color="amber" app absolute clipped-left>
      <v-text-field
        solo-inverted
        flat
        hide-details
        label="Search"
        prepend-inner-icon="search"
        v-model="search"
      ></v-text-field>
    </v-toolbar>
    <v-content>
      <v-container fluid fill-height class="grey lighten-4">
        <v-layout justify-center align-center>
          <v-flex shrink></v-flex>
          <v-flex class="fab-container">
            <v-btn color="blue" dark meddium fab>
              <v-icon>edit</v-icon>
            </v-btn>
            <v-btn color="green" dark meddium fab @click="openModal">
              <v-icon>add</v-icon>
            </v-btn>
          </v-flex>
        </v-layout>
      </v-container>
      <pet-form-modal v-on:pushPet="pushPet" ref="PetForm"></pet-form-modal>
    </v-content>
  </v-layout>
</template>

<script>
import PetFormModal from '../pet/PetFormModal.vue';

export default {
  components: {PetFormModal},
  data() {
    return {
      search: null,
      petModal: false,
      petList:[]
    };
  },
  watch: {
    search(val) {}
  },
  methods: {
    openModal() {
      this.$refs.PetForm.openModal()
    },
    pushPet(pet) {
      this.petList.push(pet)
    }
  },
};
</script>

<style>
.fab-container {
  position: fixed;
  bottom: 0;
  right: 0;
}
</style>