<template>
  <v-layout>
    <v-toolbar color="amber" app absolute clipped-left>
      <v-layout align-center>
        <v-flex xs7 md10>
          <v-text-field
            solo-inverted
            flat
            hide-details
            label="Search"
            prepend-inner-icon="search"
            v-model="search"
          ></v-text-field>
        </v-flex>
        <v-flex xs5 md2 pa-3 mt-3>
          <v-switch @change="filterListOfPets" ml-2 v-model="isAdocao" label="Pets para adoção"></v-switch>
        </v-flex>
      </v-layout>
    </v-toolbar>

    <v-content>
      <v-container fluid fill-height class="grey lighten-4">
        <v-layout col wrap>
          <pet-cards ref="petCards"></pet-cards>
          <v-flex class="fab-container">
            <v-btn v-show="selectedPet.id > 0" color="blue" dark meddium fab @click="editPet">
              <v-icon>edit</v-icon>
            </v-btn>
            <v-btn color="green" dark meddium fab @click="newPet">
              <v-icon>add</v-icon>
            </v-btn>
          </v-flex>
        </v-layout>
      </v-container>
      <pet-form-modal v-on:loadPets="loadPets" ref="PetForm"></pet-form-modal>
    </v-content>
  </v-layout>
</template>

<script>
import PetFormModal from "../pet/PetFormModal.vue";
import PetCards from "../pet/PetCards.vue";
import { mapState } from "vuex";
export default {
  computed: mapState(["selectedPet"]),
  components: { PetFormModal, PetCards },
  data() {
    return {
      search: null,
      petModal: false,
      petList: [],
      isAdocao: false
    };
  },
  watch: {
    search() {
      this.filterListOfPets()
    }
  },
  methods: {
    editPet() {
      this.$refs.PetForm.openModal();
      this.$refs.PetForm.mode = "edit";
    },
    newPet() {
      this.$store.commit("setPet", {});
      this.$refs.PetForm.openModal();
      this.$refs.PetForm.mode = "new";
    },
    filterListOfPets(){
      this.$refs.petCards.filterListOfPets(this.search,this.isAdocao)
    },
    loadPets() {
      this.$refs.petCards.loadPets()
    }
  }
};
</script>

<style>
.fab-container {
  position: fixed;
  bottom: 0;
  right: 0;
}
</style>