<template>
  <div class="menu">
    <button @click="scan">Scan</button>
  </div>
</template>

<script>
export default {
  data() {
    return {
    }
  },
  methods: {
    scan() {
      alert('TODO!')
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
}
</style>
