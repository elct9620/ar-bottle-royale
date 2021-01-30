import consumer from "./consumer"
import PlayerEvent from 'events/player'

consumer.subscriptions.create("PlayerChannel", {
  connected() {
    this.perform('load_avatar')
    this.perform('load_inventories')

    PlayerEvent.$on('do:use_item', ({ inventory_id }) => this.perform('use_item', { inventory_id }))
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },
  received({ action, payload }) {
    PlayerEvent.$emit(action, payload)
  }
});
