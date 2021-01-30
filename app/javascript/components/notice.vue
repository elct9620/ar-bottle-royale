<template>
  <div class="center" v-show="visible">
    <img :src="playerInCombat" />
  </div>
</template>

<script>
import PlayerEvent from 'events/player'
import playerInCombat from 'assets/player_in_combat'

export default {
  data() {
    return {
      visible: false,
      playerInCombat
    }
  },
  mounted() {
    PlayerEvent.$on('player:in_combat', ()=> {
      this.visible = true
      setTimeout(() => this.visible = false, 1000)
    })
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
