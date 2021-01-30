<template>
  <div class="item-menu">
    <a v-for="item in items" @click="use(item)">
      <img :src="item.icon" />
    </a>
  </div>
</template>

<script>
import PlayerEvent from 'events/player'

const assets = require.context('assets', true)
const iconPath = (name) => assets(name, true)

export default {
  data() {
    return {
      items: []
    }
  },
  mounted() {
    PlayerEvent.$on('inventory:changed', ({ inventories }) => {
      this.items = inventories.map(inv => {
        return {
          id: inv.id,
          name: inv.item.name,
          icon: iconPath(`./${inv.item.icon_name}.png`)
        }
      } )
    })
  },
  methods: {
    use(item) {
      PlayerEvent.$emit('do:use_item', { inventory_id: item.id })
    }
  }
}
</script>

<style scoped>
.item-menu {
  position: fixed;
  left: 0;
  bottom: 0;

  width: 100vw;
  height: 64px;

  text-align: center;

  z-index: 999999;
}
</style>
