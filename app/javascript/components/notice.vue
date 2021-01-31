<template>
  <div class="center" v-show="visible">
    <img :src="playerInCombat" v-show="mode == 0" />
    <img :src="playerGetKilled" v-show="mode == 1" />
    <img :src="playerKillEnemy" v-show="mode == 2" />
  </div>
</template>

<script>
import PlayerEvent from 'events/player'

import playerInCombat from 'assets/player_in_combat'
import playerGetKilled from 'assets/get_killed_by'
import playerKillEnemy from 'assets/kill_an_enemy'

export default {
  data() {
    return {
      visible: false,
      mode: 0,
      playerInCombat,
      playerGetKilled,
      playerKillEnemy
    }
  },
  mounted() {
    PlayerEvent.$on('player:in_combat', ()=> this.showNotice(0))
    PlayerEvent.$on('player:killed', ()=> this.showNotice(1))
    PlayerEvent.$on('player:defeat_foe', ()=> this.showNotice(2))
  },
  methods: {
    showNotice(mode) {
      this.mode = mode
      this.visible = true
      setTimeout(() => this.visible = false, 1000)
    }
  }
}
</script>

<style scoped>
.center {
  position: fixed;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  z-index: 999;
}
</style>
