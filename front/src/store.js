import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    selectedPet: {}
  },
  mutations: {
    setPet(state, pet) {
      state.selectedPet = pet
    }
  }
})
