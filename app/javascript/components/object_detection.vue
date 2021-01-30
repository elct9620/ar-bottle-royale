<template>
  <div class="frame" :style="frameStyle">
    <div class="loading" v-show="loading">LOADING</div>
    <detection-area v-for="item of confirmedPredictions" :prediction="item" :scaleX="scaleX" :scaleY="scaleY" />
  </div>
</template>

<script>
import MapEvent from 'events/map'
import DetectionArea from 'components/detection_area';

export default {
  components: {
    'detection-area': DetectionArea
  },
  data() {
    return {
      loading: true,
      model: null,
      video: null,
      scaleX: 1,
      scaleY: 1,
      vidoeWidth: '100%',
      videoHeight: '100%',
      videoOffsetLeft: '0',
      videoOffsetTop: '0',
      predictions: [],
      lastDetectTime: 0,
      nextDetectTime: 0,
    }
  },
  async mounted() {
    MapEvent.$on('do:scan', () => {
      MapEvent.$emit('do:collect', { items: this.predictions.map(p => p.class) })
    })
    this.getARJSVideo()
    this.model = await cocoSsd.load()
    this.loading = false
    this.detectObject()
  },
  methods: {
    getARJSVideo() {
      if (this.video) {
        this.scaleX = this.video.clientWidth / this.video.videoWidth;
        this.scaleY = this.video.clientHeight / this.video.videoHeight;

        this.videoWidth = this.video.style.width;
        this.videoHeight = this.video.style.height;
        this.videoOffsetLeft = this.video.style.marginLeft;
        this.videoOffsetTop = this.video.style.marginTop;

        setTimeout(() => this.getARJSVideo(), 1000)

        return;
      }

      const $video = document.getElementById('arjs-video')
      this.video = $video;

      setTimeout(() => this.getARJSVideo(), 100)
    },
    scheduleNext() {
      requestAnimationFrame(() => {
        if (this.nextDetectTime <= 0) {
          this.detectObject()
          this.nextDetectTime = 1000;
        } else {
          this.scheduleNext()
        }

        this.nextDetectTime -= (new Date()).getTime() - this.lastDetectTime
        this.lastDetectTime = (new Date()).getTime()
      });
    },
    detectObject() {
      if (!this.video) {
        this.scheduleNext()
        return;
      }

      if(this.video && this.video.paused) {
        this.scheduleNext()
        return;
      }

      this.model.detect(this.video).then(predictions => {
        this.predictions = predictions;

        this.scheduleNext();
      });
    }
  },
  computed: {
    confirmedPredictions() {
      return this.predictions.filter(p => p.score >= 0.7)
    },
    frameStyle() {
      if (!this.video) {
        return {}
      }

      return {
        width: this.videoWidth,
        height: this.videoHeight,
        marginLeft: this.videoOffsetLeft,
        marginTop: this.videoOffsetTop
      }
    }
  }
}
</script>

<style scoped>
.frame {
  position: fixed;

  width: 100%;
  height: 100%;

  top: 0;
  left: 0;

  pointer-events: none;
}

.loading {
  position: absolute;

  width: 100%;
  height: 100%;

  background: black;
  color: white;
  text-align: center;

  z-index: 999999999;

  /* Move Out */
}
</style>
