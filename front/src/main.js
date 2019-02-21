import Vue from 'vue'
import './plugins/vuetify'
import App from './App.vue'
import './config/msgs'
import './config/axios'

Vue.config.productionTip = false

new Vue({
  render: h => h(App),
}).$mount('#app')
