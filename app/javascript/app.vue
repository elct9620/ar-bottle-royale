<template>
  <a-scene
    vr-mode-ui="enabled: false;"
    renderer="logarithmicDepthBuffer: true;"
    embedded
    arjs="trackingMethod: best; sourceType: webcam;debugUIEnabled: false;"
    >

    <a-assets>
      <a-asset-item ref="sword" src="/models/ggj_prp_wep_001.gltf"></a-asset-item>
    </a-assets>

    <a-entity gltf-model="/models/ggj_prp_wep_001.gltf" position="0 -5 -30"></a-entity>
  </a-scene>
</template>

<script>
export default {
  data: function () {
    return {
    }
  }
}
</script>

<style scoped>
</style>
