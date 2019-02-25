<template>
  <v-layout row wrap>
    <v-flex xs12 sm6 md4 pa-2 v-for="pet in filteredListOfPets" :key="pet.id">
      <pet-card @click.native="onClick(pet)" :pet="pet"></pet-card>
    </v-flex>
  </v-layout>
</template>
<script>

import PetCard from './PetCard.vue';
import axios from 'axios';
import { baseApiUrl, showError } from "@/global";

export default {
  components: {PetCard},
  data() {
    return {
      listOfPets:[],
      filteredListOfPets: []
    }
  },methods: {
    loadPets() {
      axios
        .get(`${baseApiUrl}/animais`)
        .then(res => {
          this.listOfPets = res.data
          this.filteredListOfPets = this.listOfPets
        }).catch(showError)
      
    },
    onClick(pet){
      this.$store.commit('setPet',pet)
    },
    filterListOfPets(search,isAdocao){
      this.filteredListOfPets = this.listOfPets.filter(e => {
        const retorno = (isAdocao ? !e.dtDeath : true) && (search ? e.name.toLowerCase().includes(search.toLowerCase()) : true)
        return retorno
      })
    }
  },mounted() {
    this.loadPets()
  },
};
</script>

<style>

</style>
