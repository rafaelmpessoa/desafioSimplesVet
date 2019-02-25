<template>
  <v-card
    :class="classPet"
    style="cursor:pointer"
  >
    <v-layout row wrap align-center>
      <v-flex xs4>
        <v-card-media
          :src="require(`@/assets/img/${parseInt(pet.kindOfPet) === 1 ? 'dog':'cat'}/${pet.path}.jpeg`)"
        ></v-card-media>
      </v-flex>
      <v-flex xs8>
        <v-layout column wrap>
          <v-flex>
            <v-card-title primary-title>
              <div>
                <div class="headline">{{pet.name}}</div>
              </div>
            </v-card-title>
          </v-flex>
          <v-flex>
            <v-card-text>
              <ul>
                <li>{{pet.gender}}.</li>
                <li>{{pet.age}} Anos.</li>
                <li>{{pet.chip}}.</li>
                <li>{{pet.dtDeath ? "Falecido" : "Vivo"}}.</li>
              </ul>
            </v-card-text>
          </v-flex>
        </v-layout>
      </v-flex>
    </v-layout>
  </v-card>
</template>
<script>
import { mapState } from "vuex";

export default {
  props: { pet: Object },
  computed: {
    ...mapState(["selectedPet"]),
    classPet() {
      const objClass = {"black--text": true};
      if (this.pet.id === this.selectedPet.id) {
        objClass["green lighten-4"] = true;
      } else {
        (objClass["lime lighten-5"] = this.pet.isAlive),
        (objClass["grey lighten-2"] = !this.pet.isAlive);
      }
      return objClass;
    }
  }
};
</script>

<style scoped>
ul {
  list-style-type: none;
}
</style>


