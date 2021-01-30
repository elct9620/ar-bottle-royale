import consumer from "./consumer"
import PlayerEvent from 'events/player'

consumer.subscriptions.create("PlayerChannel", {
  connected() {
    this.perform('load_avatar')
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },
  received({ action, payload }) {
    PlayerEvent.$emit(action, payload)
  }
});
