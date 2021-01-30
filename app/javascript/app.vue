<template>
  <div id="app">
    <nearby-player />
      <!-- <object-detection /> -->
    <player-menu />
  </div>
</template>

<script>
import NearbyPlayer from 'components/nearby_player'
import ObjectDetection from 'components/object_detection'
import Menu from 'components/menu'

export default {
  components: {
    'nearby-player': NearbyPlayer,
    'object-detection': ObjectDetection,
    'player-menu': Menu
  },
  data: function () {
    return {
    }
  }
}
</script>

<style scoped>
</style>
