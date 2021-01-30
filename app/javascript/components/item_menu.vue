<template>
  <div class="item-menu">
    <button v-for="item in items" @click="use(item)">{{ item.name }}</button>
  </div>
</template>

<script>
export default {
  data() {
    return {
      items: [{
        id: 0,
        name: 'Dummy Item'
      }]
    }
  },
  methods: {
    use(item) {
      alert('Use Item!')
    }
  }
}
</script>

<style scoped>
button {
  display: inline-block;

  color: white;
  background: blue;
  border: none;

  text-align: center;

  width: 64px;
  height: 64px;
}

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
