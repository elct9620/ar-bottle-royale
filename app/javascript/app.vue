<template>
  <div id="app">
    <nearby-player />
      <object-detection />
  </div>
</template>

<script>
import NearbyPlayer from 'components/nearby_player'
import ObjectDetection from 'components/object_detection'

export default {
  components: {
    'nearby-player': NearbyPlayer,
    'object-detection': ObjectDetection
  },
  data: function () {
    return {
    }
  }
}
</script>

<style scoped>
</style>
