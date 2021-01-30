<template>
  <a-scene
    vr-mode-ui="enabled: false;"
    renderer="logarithmicDepthBuffer: true;"
    embedded
    arjs="trackingMethod: best; sourceType: webcam;debugUIEnabled: false;"
    >
    <a-entity gltf-model="/models/ggj_prp_wep_001.gltf" position="0 -5 -30"></a-entity>

    <nearby-player />
  </a-scene>
</template>

<script>
import NearbyPlayer from 'components/nearby_player'

export default {
  components: {
    'nearby-player': NearbyPlayer,
  },
  data: function () {
    return {
    }
  },
}
</script>

<style scoped>
</style>
