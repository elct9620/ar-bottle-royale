// Vue
import Vue from 'vue'
import App from 'app'

Vue.config.ignoredElements = [
  /^a-/
]

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    render: h => h(App)
  })

  const $loading = document.getElementById('loading')
  const $app = document.getElementById('app')

  cocoSsd.load().then(() => {
    $loading.style.display = 'none'
    if ($app) {
      require("channels")
      app.$mount($app)
    }
  })
})
