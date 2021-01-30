<template>
  <a class="player-list" @click="onClick">
    <img :src="avatarUrl" :srcset="avatarUrl" class="avatar" />
    {{ displayName }}
  </a>
</template>

<script>
import PlayerEvent from 'events/player'

export default {
  data() {
    return {
    }
  },
  props: {
    id: { required: true, type: Number },
    name: { required: true, type: String },
  },
  methods: {
    onClick(ev) {
      ev.preventDefault();

      PlayerEvent.$emit('attack:player', this.id)
    }
  },
  computed: {
    displayName() {
      return `${this.name}#${this.id}`
    },
    avatarUrl() {
      return `https://avatars.dicebear.com/4.5/api/bottts/${this.name}_${this.id}.svg`
    }
  }
}
</script>

<style scoped>
.player-list {
  display: block;

  color: white;
  text-decoration: none;
  text-shadow: 0 0 5px black;

  margin: 0.5em 1em;
}

.avatar {
  display: inline-block;
  vertical-align: middle;

  width: 32px;
  height: 32px;
}
</style>
