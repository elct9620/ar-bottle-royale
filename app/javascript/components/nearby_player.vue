<template>
  <div class="nearby-player">
    <player-avatar v-for="player in players" :key="player.id" v-bind="player" />
  </div>
</template>

<script>
import PlayerEvent from 'events/player'
import PlayerAvatar from 'components/player_avatar'

export default {
  components: {
    'player-avatar': PlayerAvatar,
  },
  data() {
    return {
      players: []
    }
  },
  mounted() {
    PlayerEvent.$on('player:refresh', payload => {
      if (this.players.find(player => player.id == payload.avatar.id) === undefined) {
        this.players.unshift(payload.avatar)
      }

      if (this.players.length >= 5) {
        this.players.pop()
      }
    })
  }
}
</script>

<style scoped>
.nearby-player {
  position: fixed;

  top: 100px;
  left: 20px;

  z-index: 999999;
}
</style>
