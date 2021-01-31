<template>
  <div id="app">
    <notice />
    <nearby-player :avatar="avatar" v-if="searchMode" />
    <object-detection />
    <player-menu :mode="mode" :avatar="avatar" />
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
import Notice from 'components/notice'

export default {
  components: {
    'nearby-player': NearbyPlayer,
    'object-detection': ObjectDetection,
    'player-menu': Menu,
    'item-menu': ItemMenu,
    'notice': Notice
  },
  data: function () {
    return {
      hurtSounds: [
        '#hurt_004',
        '#hurt_005'
      ],
      avatar: null,
      mode: 'search',
      envSound: null,
      sfx: null,
      foePlayer: null,
      combatEffect: null,
    }
  },
  mounted() {
    PlayerEvent.$on('avatar:load', ({ avatar }) => this.avatar = avatar)

    BattleEvent.$on('battle:started', ({ avatar }) => {
      this.mode = 'battle'
      this.foePlayer.setAttribute('visible', true)
      this.envSound.setAttribute('src', '#theme002')
      if (avatar.weapon) {
        this.foePlayer.setAttribute('wep', `#${avatar.weapon.asset_name}`)
      } else {
        this.foePlayer.setAttribute('wep', '')
      }

      if (avatar.armor) {
        this.foePlayer.setAttribute('arm', `#${avatar.armor.asset_name}`)
      } else {
        this.foePlayer.setAttribute('arm', '')
      }
    })

    BattleEvent.$on('damage:apply', () => {
      this.combatEffect.setAttribute('visible', true)

      const sound = this.hurtSounds[Math.floor(Math.random() * 2)]
      this.sfx.setAttribute('src', sound)
      this.sfx.components.sound.playSound()
      setTimeout(() => this.combatEffect.setAttribute('visible', false), 100)
    })

    BattleEvent.$on('battle:ended', () => {
      this.mode = 'search'
      this.foePlayer.setAttribute('visible', false)
      this.envSound.setAttribute('src', '#theme001')
    })

    this.envSound = document.getElementById('envSound')
    this.sfx = document.getElementById('sfx')
    this.foePlayer = document.querySelector('a-player')
    this.combatEffect = document.getElementById('combatVFX')
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
