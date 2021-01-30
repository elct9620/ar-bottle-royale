// Rails Support
require("channels")

// Vue
import Vue from 'vue'
import App from 'app'

Vue.config.ignoredElements = [
  /^a-/
]

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#app',
    render: h => h(App)
  })

  const $app = document.getElementById('app')

  if ($app) {
    app.$mount($app)
  }
})
