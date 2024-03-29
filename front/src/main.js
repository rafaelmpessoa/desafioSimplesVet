import Vue from 'vue'
import './plugins/vuetify'
import App from './App.vue'
import './config/msgs'
import './config/axios'
import store from './store'

Vue.config.productionTip = false

new Vue({
  store,
  render: h => h(App)
}).$mount('#app')
