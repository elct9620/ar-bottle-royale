<template>
  <div class="menu">
    <a @click="scan" v-if="searchMode">
      <img :src="scanIconSrc" />
    </a>
    <a @click="attack" v-if="battleMode">
      <img :src="hitIconSrc" />
    </a>
  </div>
</template>

<script>
import MapEvent from 'events/map'
import BattleEvent from 'events/battle'

import ScanIcon from 'assets/scan.png'
import HitIcon from 'assets/hit.png'

export default {
  data() {
    return {
      scanIconSrc: ScanIcon,
      hitIconSrc: HitIcon
    }
  },
  props: {
    mode: {
      type: String,
      default: 'search'
    }
  },
  methods: {
    scan(ev) {
      ev.preventDefault()

      MapEvent.$emit('do:scan')
    },
    attack(ev) {
      ev.preventDefault()

      BattleEvent.$emit('do:attack')
    }
  },
  computed: {
    searchMode() {
      return this.mode == 'search'
    },
    battleMode() {
      return this.mode == 'battle'
    }
  }
}
</script>

<style scoped>
.menu {
  position: fixed;
  left: 0;
  bottom: 64px;

  width: 100vw;
  height: 64px;

  text-align: center;

  z-index: 999999;
}
</style>
