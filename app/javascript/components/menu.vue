<template>
  <div class="status">
    <div>{{ currentHp }} / {{ maxHp }}</div>
    <div class="menu">
      <a @click="scan" v-if="searchMode">
        <img :src="scanIconSrc" />
      </a>
      <a @click="attack" v-if="battleMode">
        <img :src="hitIconSrc" />
      </a>
    </div>
  </div>
</template>

<script>
import MapEvent from 'events/map'
import BattleEvent from 'events/battle'
import PlayerEvent from 'events/player'

import ScanIcon from 'assets/scan.png'
import HitIcon from 'assets/hit.png'

export default {
  data() {
    return {
      currentAvatarState: null,
      scanIconSrc: ScanIcon,
      hitIconSrc: HitIcon
    }
  },
  props: {
    mode: {
      type: String,
      default: 'search'
    },
    avatar: {
      type: Object,
      default: null
    }
  },
  mounted() {
    PlayerEvent.$on('player:refresh', ({ avatar }) => {
      if (this.avatar.id === avatar.id) {
        this.currentAvatarState = avatar
      }
    })
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
    },
    currentHp() {
      if (!this.currentAvatarState) {
        return this.avatar ? this.avatar.hp : '???'
      }

      return this.currentAvatarState.hp
    },
    maxHp() {
      if (!this.currentAvatarState) {
        return this.avatar ? this.avatar.max_hp : '???'
      }

      return this.currentAvatarState.max_hp
    }
  }
}
</script>

<style scoped>
.status {
  position: fixed;
  left: 0;
  bottom: 64px;

  width: 100vw;
  height: 64px;

  color: white;
  text-align: center;

  z-index: 999999;
}
</style>
