<template>
  <div>
  </div>
</template>

<script>
require('@tensorflow/tfjs-backend-cpu');
require('@tensorflow/tfjs-backend-webgl');
import * as cocoSsd from '@tensorflow-models/coco-ssd/dist/index.js';

export default {
  data() {
    return {
      model: null
    }
  },
  async mounted() {
    this.model = await cocoSsd.load()
  }
}
</script>
