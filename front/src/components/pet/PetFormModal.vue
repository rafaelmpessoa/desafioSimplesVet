<template>
  <v-layout row justify-center>
    <v-dialog v-model="isOpen" persistent max-width="600px">
      <v-form ref="form">
        <v-card>
          <v-card-title>
            <span class="headline">{{mode === 'new' ? 'Cadastrar Pet': 'Alterar Pet'}}</span>
          </v-card-title>
          <v-card-text>
            <v-container grid-list-md>
              <v-layout wrap>
                <v-flex xs12>
                  <v-text-field
                    label="Nome"
                    v-model="pet.name"
                    :rules="[v => !!v || 'Campo obrigatório']"
                  ></v-text-field>
                </v-flex>
                <v-flex xs12>
                  <v-text-field
                    label="Data Nascimento"
                    v-model="pet.dtBorn"
                    mask="date-with-time"
                    :rules="[v => !!v || 'Campo obrigatório']"
                  ></v-text-field>
                </v-flex>
                <v-flex xs12>
                  <v-radio-group
                    :rules="[v => !!v || 'Campo obrigatório']"
                    v-model="pet.gender"
                    row
                  >
                    <v-radio label="Macho" value="M"></v-radio>
                    <v-radio label="Fêmea" value="F"></v-radio>
                  </v-radio-group>
                </v-flex>
                <v-flex xs12>
                  <v-radio-group
                    :rules="[v => !!v || 'Campo obrigatório']"
                    v-model="pet.kindOfPet"
                    row
                    @change="onChangeKindOfPet"
                  >
                    <v-radio label="Cachorro" :value="1"></v-radio>
                    <v-radio label="Gato" :value="2"></v-radio>
                  </v-radio-group>
                </v-flex>
                <v-flex xs12>
                  <v-select
                    v-model="pet.raca"
                    :items="racas"
                    label="Raça"
                    :rules="[v => !!v || 'Campo obrigatório']"
                    item-text="raca"
                    item-value="id"
                  ></v-select>
                </v-flex>
                <v-flex xs12>
                  <v-text-field
                    label="Chip"
                    v-model="pet.chip"
                    :rules="[v => !!v || 'Campo obrigatório']"
                  ></v-text-field>
                </v-flex>
                <v-flex xs12>
                  <v-text-field
                    label="Data Falecimento"
                    v-model="pet.dtDeath"
                    mask="date-with-time"
                  ></v-text-field>
                </v-flex>
              </v-layout>
            </v-container>
          </v-card-text>
          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn color="red darken-1" flat @click="closeModal">Fechar</v-btn>
            <v-btn
              color="blue darken-1"
              flat
              @click="save"
            >{{mode === 'new' ? 'Cadastrar' : 'Atualizar'}}</v-btn>
          </v-card-actions>
        </v-card>
      </v-form>
    </v-dialog>
  </v-layout>
</template>

<script>
import axios from 'axios'
import { baseApiUrl, showError } from "@/global";
import {mapState} from 'vuex';

export default {
  computed: mapState(["selectedPet"]),
  data() {
    return {
      isOpen: false,
      mode: "new",
      racas: [],
      pet: {},
      objRacas: []
    };
  },
  methods: {
    openModal() {
      this.$refs.form.resetValidation()
      this.isOpen = true;
    },
    closeModal() {
        this.isOpen = false;
        this.$refs.form.resetValidation()
        this.$store.commit('setPet',{})
    },
    save() {
        const isValid = this.$refs.form.validate();
        if(!isValid) return; //verifica se os campos obrigatorios foram preenchidos.

        const method = this.mode === 'new' ? 'post' : 'put'

        this.pet.dtBorn = this.pet.dtBorn.substring(2,4) + '-' + this.pet.dtBorn.substring(0,2) + '-' + this.pet.dtBorn.substring(4,8) //Formatar para Data
        if(this.pet.dtDeath) this.pet.dtDeath = this.pet.dtDeath.substring(2,4) + '-' + this.pet.dtDeath.substring(0,2) + '-' + this.pet.dtDeath.substring(4,8) //Formatar para Data
        
        axios[method]
          (`${baseApiUrl}/animais`,this.pet)
          .then(res => {
            this.$toasted.global.defaultSuccess();
            this.$emit('loadPets')
           // this.closeModal()
          }).catch(showError)  
    },
    loadRacas(filter) {
      axios.
        get(`${baseApiUrl}/racas?situacao=ativo`)
        .then(res => {
          this.objRacas = res.data
        })      
    },
    filterRacas(filter) {
      this.racas = this.objRacas.filter(e => e.kindOfPet === filter)
    },
    onChangeKindOfPet(){
        const filter = this.pet.kindOfPet
        this.pet.raca = null
        this.filterRacas(filter)
    }
  },watch: {
    selectedPet(val) {
      this.pet = val
      this.filterRacas(val.kindOfPet)
    }
  },mounted() {
    this.loadRacas()
  },
};
</script>

<style>
</style>
