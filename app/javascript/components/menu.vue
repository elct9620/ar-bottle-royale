<template>
  <div class="menu">
    <button @click="scan" v-if="searchMode">Scan</button>
    <button @click="attack" v-if="battleMode">Attack</button>
  </div>
</template>

<script>
import BattleEvent from 'events/battle'

export default {
  data() {
    return {
    }
  },
  props: {
    mode: {
      type: String,
      default: 'search'
    }
  },
  methods: {
    scan() {
      alert('TODO!')
    },
    attack() {
      BattleEvent.$emit('attack')
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
button {
  color: white;
  background: green;
  border: none;

  text-align: center;

  width: 64px;
  height: 64px;
}

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
