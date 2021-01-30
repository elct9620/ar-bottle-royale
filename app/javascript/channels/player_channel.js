import consumer from "./consumer"
import PlayerEvent from 'events/player'

consumer.subscriptions.create("PlayerChannel", {
  connected() {
    this.avatar = null
    this.perform('load_avatar')
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received({ action, payload }) {
    if (action === 'avatar:load') {
      this.avatar = payload.avatar
      return;
    }

    if (this.avatar && this.avatar.id !== payload.avatar.id) {
      PlayerEvent.$emit(action, payload)
    }
  }
});
