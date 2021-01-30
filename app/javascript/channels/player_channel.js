import consumer from "./consumer"
import PlayerEvent from 'events/player'

consumer.subscriptions.create("PlayerChannel", {
  connected() {
    this.avatar = null
    this.perform('load_avatar')

    PlayerEvent.$on('battle:created', () => this.perform('join_battle'))
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received({ action, payload }) {
    PlayerEvent.$emit(action, payload)
  }
});
