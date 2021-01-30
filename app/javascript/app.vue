<template>
  <a-scene
    vr-mode-ui="enabled: false;"
    renderer="logarithmicDepthBuffer: true;"
    embedded
    arjs="trackingMethod: best; sourceType: webcam;debugUIEnabled: false;"
    >
    <a-entity gltf-model="/models/ggj_prp_wep_001.gltf" position="0 -5 -30"></a-entity>

    <nearby-player />
    <object-detection />
  </a-scene>
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
  },
}
</script>

<style scoped>
</style>
