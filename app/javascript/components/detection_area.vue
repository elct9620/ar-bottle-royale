<template>
  <div :style="style" class="area">
    <div class="label">{{ prediction.class }} - {{ prediction.score.toFixed(2) }}</div>
  </div>
</template>

<script>
export default {
  data() {
    return {
    }
  },
  props: {
    prediction: {
      type: Object
    },
    scaleX: {
      type: Number,
      default: 1
    },
    scaleY: {
      type: Number,
      default: 1
    }
  },
  computed: {
    width() {
      return this.prediction.bbox[2] * this.scaleX;
    },
    height() {
      return this.prediction.bbox[3] * this.scaleY;
    },
    x() {
      return this.prediction.bbox[0] * this.scaleX;
    },
    y() {
      return this.prediction.bbox[1] * this.scaleY;
    },
    style() {
      return {
        transform: `translate(${this.x}px, ${this.y}px)`,
        width: `${this.width}px`,
        height: `${this.height}px`
      }
    }
  }
}
</script>

<style scoped>
.area {
  position: absolute;

  border: 1px solid red;
}

.label {
  background: red;
  color: white;

  padding: .5em 1em;
}
</style>
