<template>
  <div id="app">
    <nearby-player :avatar="avatar" v-if="searchMode" />
    <!-- <object-detection /> -->
    <player-menu :mode="mode" />
    <item-menu />
  </div>
</template>

<script>
import PlayerEvent from 'events/player'
import BattleEvent from 'events/battle'

import NearbyPlayer from 'components/nearby_player'
import ObjectDetection from 'components/object_detection'
import Menu from 'components/menu'
import ItemMenu from 'components/item_menu'

export default {
  components: {
    'nearby-player': NearbyPlayer,
    'object-detection': ObjectDetection,
    'player-menu': Menu,
    'item-menu': ItemMenu
  },
  data: function () {
    return {
      avatar: null,
      mode: 'search',
      foePlayer: null,
    }
  },
  mounted() {
    PlayerEvent.$on('avatar:load', ({ avatar }) => this.avatar = avatar)

    BattleEvent.$on('battle:started', () => {
      this.mode = 'battle'
      this.foePlayer.setAttribute('visible', true)
    })

    BattleEvent.$on('battle:ended', () => {
      this.mode = 'search'
      this.foePlayer.setAttribute('visible', false)
    })

    this.foePlayer = document.querySelector('a-player')
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
</style>
