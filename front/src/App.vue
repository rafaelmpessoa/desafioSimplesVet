<template>
  <v-app>
    <home-page/>
  </v-app>
</template>

<script>
import HomePage from './components/templates/HomePage'

export default {
  name: 'App',
  components: {
    HomePage
  },
  data () {
    return {
      //
    }
  }
}
</script>
